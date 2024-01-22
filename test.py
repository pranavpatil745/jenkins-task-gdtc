# # try:

# #     import json
# #     import sys
# #     import requests
# #     print("All imports ok ...")
# # except Exception as e:
# #     print("Error Imports : {} ".format(e))


# def lambda_handler(event, context):

#     print("Hello AWS!, This is my first time creating Jenkins and Docker Pipeline")
#     print("event = {}".format(event))
#     return {
#         'statusCode': 200,
#         'body': 'Hello from Lambda using ECR image!',
        
#     }