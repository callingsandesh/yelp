import sys
import json
filepath='/home/sandesh/Desktop/new_leapfrog/Leapfrog-Assignment/Data/final_project'
sys.path.append(filepath)

from src.utils import connect

from src.helper import execute_bulk_insert

# from ..utils import connect
# from ..helper import execute_bulk_insert



def extract_data(file_path,query_path,database_name,batch_size):
    #print(database_name)
    with open(query_path,'r') as q:
        q=q.read()

    print(q)
    print(file_path)
    


    with open(file_path,'r') as f:
        data=[]
        i=0
        for line in f:
            data.append(json.loads(line))
            i+=1

            if i==batch_size:
                execute_bulk_insert(q,connect(database_name),data)
                i=0
                data=[]
                continue
        #execute the remaining data
        if data!=[]:
            execute_bulk_insert(q,connect(database_name),data)
        
            
            

if __name__=='__main__':
    database_name="yelp_db"
    batch_size=10000

    file_paths_and_query_path ={
                'user':['../../datasets/yelp_dataset/yelp_academic_dataset_user.json','../sql/insert_into_raw_user.sql'],
                'business':['../../datasets/yelp_dataset/yelp_academic_dataset_business.json','../sql/insert_into_raw_business.sql'],
                'photos':['../../datasets/yelp_dataset/photos.json','../sql/insert_into_raw_photo.sql'],
                'tip':['../../datasets/yelp_dataset/yelp_academic_dataset_tip.json','../sql/insert_into_raw_tip.sql'],
                'review':['../../datasets/yelp_dataset/yelp_academic_dataset_review.json','../sql/insert_into_raw_review.sql'],
                'checkin':['../../datasets/yelp_dataset/yelp_academic_dataset_checkin.json','../sql/insert_into_raw_checkin.sql']
                }
    
    for paths in file_paths_and_query_path.values():
        extract_data(paths[0],paths[1],database_name,batch_size)
    
