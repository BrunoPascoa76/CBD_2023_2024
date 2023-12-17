from neo4j import GraphDatabase, RoutingControl
from pprint import pprint
from time import perf_counter

def import_csv(driver,reset=False):
    """Imports data from csv"""
    #note: some information that is irrelevant to this exercise will not be included (like Memory or Equip_Slots)
    if reset:
        reset_db(driver)
        create_indexes(driver)
    print("importing from csv...")
    start_time=perf_counter()
    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Digimon.csv' as row
        MERGE (d:Digimon {number:toInteger(row.Number)})
        MERGE (s:Stage {name:row.Stage})
        MERGE (t:Type {name:row.Type})
        MERGE (a:Attribute {name:row.Attribute})
        MERGE (d)-[:IS]->(s)
        MERGE (d)-[:IS]->(t)
        MERGE (d)-[:IS]->(a) 
        SET d={
            number:toInteger(row.Number), 
            name:row.Digimon,
            maxHP: toInteger(row.HP_lvl_99),
            maxSP: toInteger(row.SP_lvl_99),
            maxATK:toInteger(row.ATK_lvl_99),
            maxDEF:toInteger(row.DEF_lvl_99),
            maxINT:toInteger(row.INT_level_99),
            maxSPD:toInteger(row.SPD_lvl_99)
        }
        """, database_="digimon"
    )
    digimon_time=perf_counter()
    print(f"imported digimon in {digimon_time-start_time}s")

    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Attributes.csv' as row
        MERGE (strong:Attribute {name: row.strong_attribute})
        MERGE (weak:Attribute {name: row.weak_attribute})
        MERGE (strong)-[sa:STRONG_AGAINST]->(weak)
        SET sa.multiplier=1.5
        """, database_="digimon"
    )
    attribute_time=perf_counter()
    print(f"imported attribute relations in {attribute_time-digimon_time}s")

    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Types.csv' as row
        MERGE (strong:Type {name: row.strong_type})
        MERGE (weak:Type {name: row.weak_type})
        MERGE (strong)-[sa:STRONG_AGAINST]->(weak)
        SET sa.multiplier=2.0
        """, database_="digimon"
    )
    type_time=perf_counter()
    print(f"imported types in {type_time-attribute_time}s")

    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Skills.csv' as row
        MERGE (s:Skill {name:row.Skill})
        MERGE (t:Skill_Type {name: row.Type})
        MERGE (a:Attribute {name: row.Attribute})
        MERGE (s)-[:IS]->(t)
        MERGE (s)-[:IS]->(a)
        SET s={
            name:row.Skill,
            cost:toInteger(row.SP_Cost),
            power:toInteger(row.Power),
            description:row.Description
        }
        """, database_="digimon"
    )
    
    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Skills_by_Digimon.csv' as row
        MERGE (d:Digimon {name:row.Digimon})
        MERGE (s:Skill {name:row.Skill})
        MERGE (d)-[h:HAS]->(s)
        SET h.level=toInteger(row.Level)
        """, database_="digimon"
    )
    skill_time=perf_counter()
    print(f"imported skills in {skill_time-type_time}s")

    driver.execute_query(
        """
        LOAD CSV WITH HEADERS FROM 'file:///digimon/Digivolutions.csv' as row
        MATCH (from:Digimon {name: row.Digivolves_from})
        MERGE (to:Digimon {name: row.Digivolves_to})
        MERGE (from)-[:EVOLVES]->(to)
        """, database_="digimon"
    )
    digivolution_time=perf_counter()
    print(f"imported digivolutions in {digivolution_time-skill_time}")
    print(f"finished importing in {digivolution_time-start_time}s")
    
def reset_db(driver):
    """Clears the database"""
    print("resetting...")
    driver.execute_query(
        "MATCH (n) "
        "DETACH DELETE n",
        database_="digimon"
    )
    print("reset complete")

def create_indexes(driver):
    print("creating indexes...")
    #indexes created to optimize importing:
    driver.execute_query(
        "CREATE INDEX digimon_number_index IF NOT EXISTS FOR (d:Digimon) ON (d.number) ",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX digimon_name_index IF NOT EXISTS FOR (d:Digimon) ON (d.name)",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX digimon_number_index IF NOT EXISTS FOR (d:Digimon) ON (d.number)",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX skill_name_index IF NOT EXISTS FOR (d:Skill) ON (d.name)",
        database_="digimon"
    )
    print("index creation complete")
    





# query 1: search a digimon by name
def search(driver,digimon):
    records,_,_ = driver.execute_query(
        """
        MATCH(d:Digimon)
        WHERE d.name=$digimon_name
        RETURN d
        """,digimon_name=digimon,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n1)")
    pprint([rec.data() for rec in records])

# query 2: get all of skills of a digimon
def get_all_skills(driver,digimon):
    records,_,_ = driver.execute_query(
        """
        MATCH(d:Digimon)-[:HAS]->(s:Skill)
        WHERE d.name=$digimon_name
        RETURN d,COLLECT(s) AS skill_list
        """,digimon_name=digimon,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n2)")
    pprint([rec.data() for rec in records])

# query 3: get the digimon with the highest max value of a given stat
def get_highest_stat(driver,stat):
    records,_,_ = driver.execute_query(
        """
        MATCH(d:Digimon)
        RETURN d
        ORDER BY d.maxATK DESC
        LIMIT 1
        """,stat=stat,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n3)")
    pprint([rec.data() for rec in records])

# query 4: given a digimon, get its evolutionary line
def get_evolution_line(driver,digimon):
    records,_,_ = driver.execute_query(
        """
        MATCH(d1:Digimon)-[:EVOLVES*1..100]->(d2:Digimon)
        WHERE d1.name=$digimon_name
        RETURN d1,d2
        """,digimon_name=digimon,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n4)")
    pprint([rec.data() for rec in records])

# query 5: for each baby digimon, get the number of possible evolutions
def get_number_evolutions(driver):
    records,_,_ = driver.execute_query(
        """
        MATCH (s:Stage {name:"Baby"})<-[:IS]-(d1:Digimon)-[:EVOLVES*]->(d2:Digimon)
        RETURN d1.name AS name,COUNT(DISTINCT d2.name) AS num_evolutions
        """,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n5)")
    pprint([rec.data() for rec in records])

# query 6: given a stat and max number of evolutions, get the path to the evolution with the highest value in that stat
def get_best_line(driver,digimon):
    records,_,_ =  driver.execute_query(
        """
        MATCH(start_:Digimon)-[:EVOLVES*1..100]->(end_:Digimon)
        WHERE start_<>end_ AND start_.name=$digimon_name
        MATCH path=shortestPath((start_)-[:EVOLVES*1..100]->(end_))
        RETURN path,end_
        ORDER BY end_.maxATK DESC
        LIMIT 1
        """,digimon_name=digimon,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n6)")
    pprint([rec.data() for rec in records])

# query 7: get the number of digimon in each type
def get_num_per_type(driver):
    records,_,_ = driver.execute_query(
        """
        MATCH (d:Digimon)-[:IS]->(t:Type)
        RETURN t,COUNT(DISTINCT d.name) AS num_digimon
        ORDER BY num_digimon DESC
        """,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n7)")
    pprint([rec.data() for rec in records])

# query 8: get the average stats of all digimon
def get_avg_stats_all(driver):
    records,_,_=driver.execute_query(
        """
        MATCH(d:Digimon)
        RETURN AVG(d.maxHP) AS avg_HP, AVG(d.maxSP) AS avg_SP, AVG(d.maxATK) AS avg_ATK, AVG(d.maxDEF) AS avg_DEF, AVG(d.maxSPD) AS avg_SPD
        """,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n8)")
    pprint([rec.data() for rec in records])

# query 9: get the average stats of an evolutionary line (given the baby digimon of that line (excludes it))
def get_avg_stats_line(driver,digimon):
    records,_,_ = driver.execute_query(
        """
        MATCH(d1:Digimon)-[:EVOLVES*1..100]->(d2:Digimon)
        RETURN AVG(d2.maxHP) AS avg_HP, AVG(d2.maxSP) AS avg_SP, AVG(d2.maxATK) AS avg_ATK, AVG(d2.maxDEF) AS avg_DEF, AVG(d2.maxSPD) AS avg_SPD
        """,digimon_name=digimon,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n9)")
    pprint([rec.data() for rec in records])

# query 10: get all the "final evolution" digimon (digimon that can't evolve into anything are marked as 'N/A' in the dataset)
def get_final_evolutions(driver):
    records,_,_ = driver.execute_query(
        """
        MATCH (d:Digimon)
        WHERE NOT (d)-[:EVOLVES]->(:Digimon)
        RETURN d
        """,database_="digimon",routing_=RoutingControl.READ
    )
    print("\n10)")
    pprint([rec.data() for rec in records])


def main():
    with GraphDatabase.driver("bolt://localhost:7687") as driver:
        import_csv(driver,True)
        search(driver,"Koromon")
        get_all_skills(driver,"Chaosmon")
        get_highest_stat(driver,"ATK")
        get_evolution_line(driver,"Botamon")
        get_number_evolutions(driver)
        get_best_line(driver,"Botamon")
        get_num_per_type(driver)
        get_avg_stats_all(driver)
        get_avg_stats_line(driver,"Botamon")
        get_final_evolutions(driver)


if __name__=="__main__":
    main()