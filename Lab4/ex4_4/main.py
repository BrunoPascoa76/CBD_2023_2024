from neo4j import GraphDatabase, RoutingControl
from pprint import pprint


def import_csv(driver,reset=False):
    """Imports data from csv"""
    if reset:
        reset_db(driver)
        create_indexes(driver)
    
def reset_db(driver):
    """Clears the database"""
    driver.execute_query(
        "MATCH (n)"
        "DETACH DELETE n",
        database_="digimon"
    )

def create_indexes(driver):
    #indexes created to optimize importing:
    driver.execute_query(
        "CREATE INDEX digimon_number_index FOR (d:Digimon) ON (d.number) IF NOT EXISTS",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX digimon_name_index FOR (d:Digimon) ON (d.name) IF NOT EXISTS",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX digimon_number_index FOR (d:Digimon) ON (d.number) IF NOT EXISTS",
        database_="digimon"
    )
    driver.execute_query(
        "CREATE INDEX skill_name_index FOR (d:Skill) ON (d.name) IF NOT EXISTS",
        database_="digimon"
    )
    

# query 1: search a digimon by name
def search(driver):
    pass

# query 2: get all of moves of a digimon
def get_all_moves(driver,name):
    pass

# query 3: get the digimon with the highest max value of a given stat
def get_highest_stat(driver,digimon,stat):
    pass

# query 4: given a digimon, get its evolutionary line
def get_evolution_line(driver,digimon):
    pass

# query 5: for each baby digimon, get the number of possible evolutions
def get_number_evolutions(driver,digimon):
    pass

# query 6: given a stat and max number of evolutions, get the path to the evolution with the highest value in that stat
def get_best_line(driver,digimon):
    pass

# query 7: get the number of digimon in each type
def get_num_per_type(driver):
    pass

# query 8: get the average stats of all digimon
def get_avg_stats_all(driver):
    pass

# query 9: get the average stats of an evolutionary line (given a digimon of that line)
def get_avg_stats_line(driver,digimon):
    pass

# query 10: get all the "final evolution" digimon (digimon that can't evolve into anything)


def main():
    with GraphDatabase.bolt_driver("bolt://localhost:7687") as driver:
        import_csv(driver)


if __name__=="__main__":
    main()