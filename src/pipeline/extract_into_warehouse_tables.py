import sys

from datetime import datetime
filepath='/home/sandesh/Desktop/new_leapfrog/Leapfrog-Assignment/Data/final_project'
sys.path.append(filepath)

from src.utils import connect
from src.helper import execute_bulk_insert

def extract_data(query_path,splitter , database_name,batchsize):
    
    #opening the query file path 
    with open(query_path,'r') as query:
        query=query.read()
    

    split_loc = query.find(splitter)
    select_query = query[split_loc:]
    print(select_query)
    
    insert_query = str(query[:split_loc])+"VALUES %s"
    print(insert_query)
    connection=connect(database_name)
    with connection.cursor(name='cur') as cursor:

        cursor.itersize = 10000
        cursor.execute(select_query)
        i=0
        data=[]
        for row in cursor:
            data.append(row)
            i+=1
            if i==batchsize:

                execute_bulk_insert(insert_query,connect(database_name),data)
                i=0
                data=[]
                continue
        ##inserting remaining data
        if data!=[]:
            execute_bulk_insert(insert_query,connect(database_name),data)
            

    


if __name__=='__main__':
    database_name="yelp_db"
    batchsize=10000
    
    #time_to_execute_the_function=input("Enter the time to schedule the query which takes long time in the format ,'%Y-%m-%d %H:%M:%S' ")
    query_path_and_splitter = {
        
        '../sql/insert_into_fact_user.sql':'SELECT',
        '../sql/insert_into_dim_elite.sql':'SELECT',
        '../sql/insert_into_fact_business.sql' : 'WITH',
        '../sql/insert_into_dim_category.sql':'WITH',
        '../sql/insert_into_link_fact_business_dim_category.sql':'WITH',
        '../sql/insert_into_fact_review.sql':'SELECT',
        '../sql/insert_into_fact_tip.sql':'SELECT',
        '../sql/insert_into_dim_photo.sql':'SELECT',
        '../sql/insert_into_dim_photo_count.sql':'SELECT',
        '../sql/insert_into_dim_review_count.sql':'SELECT',
        '../sql/insert_into_fact_checkin.sql':'WITH',
        '../sql/insert_into_total_tip_count.sql':'SELECT',
        '../sql/insert_into_total_user_tip_count.sql':'SELECT',
       

        }
    for path,splitter in query_path_and_splitter.items():
        extract_data(path,splitter,database_name,batchsize)


    #place the query which takes very long to execute here so execute it after certain time expires.
    query_path_and_splitter_long_time = {
         '../sql/insert_into_dim_total_review_words_count.sql':'WITH'
    }

    # enter the time to excute the querry after that certain time
    time_to_execute_the_function = "2021-10-07 23:59:00"
    
    while True:
        if datetime.now() > datetime.strptime(time_to_execute_the_function, '%Y-%m-%d %H:%M:%S'):
            print("Time reached")
            for path,splitter in query_path_and_splitter.items():
                extract_data(path,splitter,database_name,batchsize)
            break
    

    
