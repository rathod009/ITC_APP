# run ---------- api.py only ----------

# from flask import Flask, request, jsonify
# import pyodbc
# from flask_cors import CORS
# import logging

# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# app = Flask(__name__)
# CORS(app)

# SERVER = 'DESKTOP-EP7PF1F\\SQLEXPRESS'
# DATABASE = 'itc-app'
# USERNAME = ''
# PASSWORD = ''

# try:
#     connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
#     cursor = connection.cursor()
#     print("Successfully connected to ITC database")
# except Exception as e:
#     logging.exception(f"An error occurred: {e}")
#     print(f"Error connecting to ITC database: {e}")
#     exit()

# @app.route('/submitInquiry', methods=['POST'])
# def submit_inquiry():
#     try:
#         data = request.get_json()
#         logging.debug(f"Received data: {data}")
#         print ('Hello Its Working')
#         f_name = data.get('fName') or ""
#         l_name = data.get('lName') or ""
#         full_name = (f_name + " " + l_name).strip()
#         gender = data.get('gender') or ""
#         mobile = data.get('mobile') or ""
#         email = data.get('email') or ""
#         city = data.get('city') or ""
#         person_type = data.get('personType') or ""
#         highest_education = data.get('highestEducation') or ""
#         prior_knowledge = data.get('priorKnowledge') or ""
#         know_itc_from = data.get('knowITCFrom') or ""
#         inquiry_date = data.get('inquiryDate') or ""
#         interested_courses = ', '.join(data.get('interestedCoursesCategory', []))
#         inquiry_type = data.get('inquiryType') or ""

#         # Find the maximum existing PersonId
#         max_person_id_query = "SELECT MAX(PersonId) FROM [itc-app].dbo.a_InquiryPersonMaster"
#         cursor.execute(max_person_id_query)
#         max_person_id = cursor.fetchone()[0] or 0
#         new_person_id = max_person_id + 1

#         # Insert into a_InquiryPersonMaster
#         person_query = """
#             INSERT INTO [itc-app].dbo.a_InquiryPersonMaster (PersonId, Name, Gender, Mobile, Email, City, PersonType, PersonQualification)
#             VALUES (?, ?, ?, ?, ?, ?, ?, ?)
#         """
#         person_values = (new_person_id, full_name, gender, mobile, email, city, person_type, highest_education)
#         cursor.execute(person_query, person_values)

#         # Find the maximum existing InquiryId
#         max_inquiry_id_query = "SELECT MAX(InquiryId) FROM [itc-app].dbo.a_InquiryMaster"
#         cursor.execute(max_inquiry_id_query)
#         max_inquiry_id = cursor.fetchone()[0] or 0
#         new_inquiry_id = max_inquiry_id + 1

#         # Insert into a_InquiryMaster
#         inquiry_query = """
#             INSERT INTO [itc-app].dbo.a_InquiryMaster (InquiryId, PersonId, InquiryDate, CourseCategory, PriorKnowledge, KnowITCFrom, InquiryType)
#             VALUES (?, ?, ?, ?, ?, ?, ?)
#         """
#         inquiry_values = (new_inquiry_id, new_person_id, inquiry_date, interested_courses, prior_knowledge, know_itc_from, inquiry_type)
#         cursor.execute(inquiry_query, inquiry_values)

#         connection.commit()

#         return jsonify({'status': 'success', 'message': 'Inquiry submitted'}), 200

#     except Exception as e:
#         logging.exception(f"Error during submission: {e}")
#         connection.rollback()
#         return jsonify({'status': 'error', 'message': str(e)}), 500

# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0')