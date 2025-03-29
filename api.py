from flask import Flask, jsonify, request
from flask_cors import CORS
import pyodbc
import logging
from datetime import datetime

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)
CORS(app)

# Course Data API (remains the same)
courses = [
    {
        'title': 'Artificial Intelligence (AI), Machine Learning Language',
        'description': 'AI Concepts, Python Programming, Mathematics Essential, IoT Sensors and Devices, IoT and SQL Programming, Machine Learning and Deep Learning Language Programming, Robotics Concepts, AI Application & Project Data Science Applications, Cloud Computing',
        'imageUrl': 'assets/images/artificial.webp'
    },
    {
        'title': 'Fullstack - Web Developer / Programmer',
        'description': 'Application Development using any one tool/Framework (PHP/JAVA/.Net/Android/Python), ReactJS, AngularJS, NodeJS, MongoDB, SQL, C/C++ Programming, Website Design, CSS, Bootstrap, Scripting, SAD, Project Development (Agile Method, Application Integration, Hosting, Migration, Presentation)',
        'imageUrl': 'assets/images/programming.png'
    },
    {
        'title': 'Multimedia & Augmented Reality (3DS, MAYA)',
        'description': 'Professional Digital Graphics, Website Designing - UX-UI, 2D and 3D Animation, Audio-Video Editing, Social Media Marketing Post, VFX, AR/VR Applications, Multimedia Studio Exposure, Photography, Game Designing & Development, Digital Film Making',
        'imageUrl': 'assets/images/multimedia.png'
    },
    {
        'title': '2D/3D Engineering (CAD/CAM)',
        'description': 'Engineering Drawings, Design Concepts and Tools (BIM/Creo/Fusion 360/Revit/AutoCAD/Electrical/Solid Works, Ansys, 3DS Max, SketchUp, Lumion), Quality Control (GD and T - Geometrical Dimensioning and Tolerancing)',
        'imageUrl': 'assets/images/autodesk.png'
    },
    {
        'title': 'Accounting (Tally Prime)',
        'description': 'Tally Prime / Quick book, HR, Payroll, Inventory, Purchase, Sales, GST, Taxation, Share Market, Banking, Costing and Analysis, Online Govt. Services, Cloud Accounting exposure, New Company and GST registration and setup',
        'imageUrl': 'assets/images/accounting.png'
    },
    {
        'title': 'Data Analysis & Office Automation (PowerBI, Excel)',
        'description': 'Data Cleaning, Data Exploration, Alteryx / MS Tableau / MS Power BI, Data Parsing, Reporting, Blending & Joining Data, Data Summarize, Interactive Visualization, Creating Deskboard, SQL, MS Office, Adv. Excel, Internet Marketing, Office 365, Office Graphics, Audio-Video Editing',
        'imageUrl': 'assets/images/data_analysis.png'
    },
    {
        'title': 'IoT, Hardware - Mobile, Laptop, PC Repairing',
        'description': 'IoT Sensors, Arduino, Raspberry Pi, Wi-Fi-Bluetooth Connectivity, Microcontroller, Cloud Platform for IoT, SBCs, NodeMCU, Home Automation & CCTV Camera Installation, Laptop-PC-Peripherals-Mobile Repairing, Home Appliances Repairing',
        'imageUrl': 'assets/images/hardware.jpg'
    },
    {
        'title': 'AWS, Cloud Computing & Networking',
        'description': 'Data Center Concepts, Networking, Structured Cabling, Windows Server, A+, N+, CCNA, MCSA, MCSE, Hyper-V Servers, Linux, Virtualization-VMware, AWS - Lambda, SNS, SQS, AWS Ec2, Load Balancing, Smart Rack & Router-Firewall-Bandwidth Management',
        'imageUrl': 'assets/images/cloud.png'
    },
    {
        'title': 'Cyber Security & Ethical Hacking',
        'description': 'Network, Physical, Web and Application Security, Cloud and Virtualization Security, Vulnerability and Penetration Test, VAPT Reports, Kali Linux OS-Nessus-N-map-NETCAT, Cyber laws and Forensic, Network and IP concepts, IT infrastructure Technical utilization',
        'imageUrl': 'assets/images/ethical_hacking.jpg'
    },
    {
        'title': 'Spoken English',
        'description': 'Communication Skills, Grammar and Vocabulary, Conversational English, Public Speaking, Presentation Skills, Interview Preparation, Group Discussions, Writing Skills (Emails. Letters. & Reports).',
        'imageUrl': 'assets/images/spoken_english.png'
    },
    {
        'title': 'Internship',
        'description': 'Industry Exposure, Practical Skill Development, Project Collaboration, Professional Networking, Real-World Application, Mentorship, Teamwork, Problem-Solving, Domain-Specific Tools, Workplace Communication, Performance Evaluation.',
        'imageUrl': 'assets/images/internship.jpg'
    },
    {
        'title': 'Project',
        'description': 'Project Planning and Management, Requirement Analysis, Design and Development, Testing and Debugging, Documentation, Agile Methodologies, Version Control (Git), Collaboration Tools, Presentation and Demonstration, Client Interaction, Project Evaluation, Deployment and Maintenance.',
        'imageUrl': 'assets/images/project.png'
    },
    {
        'title': 'Corporate Training',
        'description': 'Leadership Development, Team Building, Communication Skills, Time Management, Project Management, Software Proficiency, Industry Compliance, Customer Service, Sales Training, Data Analysis, Cybersecurity Awareness.',
        'imageUrl': 'assets/images/corporate.png'
    },
    {
        'title': 'Crash Course',
        'description': 'Intensive Skill Acquisition, Accelerated Learning, Focused Curriculum, Practical Exercises, Quick Project Completion, Essential Concepts, Time-Bound Training, Exam Preparation (if applicable), Skill Refreshment, Immediate Application, Rapid Prototyping.',
        'imageUrl': 'assets/images/crash-course.png'
    },
    {
        'title': 'Customised Training',
        'description': 'Tailored Curriculum, Individualized Learning Paths, Specific Industry Needs, Company-Specific Tools, Flexible Scheduling, On-Demand Support, Skill Gap Analysis, Performance Improvement, Role-Specific Training, Personalized Projects, Adaptable Content, Targeted Objectives.',
        'imageUrl': 'assets/images/customised.png'
    },
    {
        'title': 'Other',
        'description': 'Needs Assessment and Consultation, Skill Gap Analysis, Event Planning and Execution, Technical Support, Curriculum Development, Community Outreach Programs, Industry Partnership Coordination, Mentorship Programs, Specialized Workshops, Customized Seminars.',        
        'imageUrl': 'assets/images/other.png'
    },
]

@app.route('/courses', methods=['GET'])
def get_courses():
    return jsonify(courses)

# Database Inquiry API
SERVER = 'lmsserver-sql.itcmogri.org'
DATABASE = 'ITC'
USERNAME = 'itc-app'
PASSWORD = 'AnoopaM@143'

try:
    connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
    cursor = connection.cursor()
    print("Successfully connected to ITC database")
except Exception as e:
    logging.exception(f"An error occurred: {e}")
    print(f"Error connecting to ITC database: {e}")
    exit()

@app.route('/submitInquiry', methods=['POST'])
def submit_inquiry():
    connection = None
    try:
        connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
        cursor = connection.cursor()
        data = request.get_json()
        logging.debug(f"Received data: {data}")
        f_name = data.get('fName') or ""
        l_name = data.get('lName') or ""
        full_name = (f_name + " " + l_name).strip()
        gender = data.get('gender') or ""
        mobile = data.get('mobile') or ""
        email = data.get('email') or ""
        city = data.get('city') or ""
        person_type = data.get('personType') or ""
        highest_education = data.get('highestEducation') or ""
        prior_knowledge = data.get('priorKnowledge') or ""
        know_itc_from = data.get('knowITCFrom') or ""
        inquiry_date_str = data.get('inquiryDate') or ""
        inquiry_time_str = data.get('inquiryTime') or "00:00"
        interested_course = ', '.join(data.get('courseCategory', []))
        inquiry_category = data.get('inquiryCategory') or ""

        # Convert inquiry_date and inquiry_time separately
        try:
            inquiry_date_obj = datetime.strptime(inquiry_date_str, '%Y-%m-%d').date()
            inquiry_time_obj = datetime.strptime(inquiry_time_str, '%H:%M').time()
            inquiry_time_string = inquiry_time_obj.strftime('%H:%M')
            inquiry_datetime_obj = datetime.combine(inquiry_date_obj, inquiry_time_obj)

        except ValueError as e:
            logging.error(f"Date/Time parsing error: {e}")
            return jsonify({'status': 'error', 'message': 'Invalid date or time format'}), 400

        # Find the maximum existing PersonId
        max_person_id_query = "SELECT MAX(PersonId) FROM [ITC].dbo.a_InquiryPersonMaster"
        cursor.execute(max_person_id_query)
        max_person_id = cursor.fetchone()[0] or 0
        new_person_id = max_person_id + 1

        # Insert into a_InquiryPersonMaster
        person_query = """
            INSERT INTO [ITC].dbo.a_InquiryPersonMaster (PersonId, Name, Gender, Mobile, Email, City, PersonType, PersonQualification)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        person_values = (new_person_id, full_name, gender, mobile, email, city, person_type, highest_education)
        cursor.execute(person_query, person_values)

        # Find the maximum existing InquiryId
        max_inquiry_id_query = "SELECT MAX(InquiryId) FROM [ITC].dbo.a_InquiryMaster"
        cursor.execute(max_inquiry_id_query)
        max_inquiry_id = cursor.fetchone()[0] or 0
        new_inquiry_id = max_inquiry_id + 1

        # Insert into a_InquiryMaster
        inquiry_query = """
            INSERT INTO [ITC].dbo.a_InquiryMaster (InquiryId, PersonId, InquiryDate, Time, Flag, KnowITCFrom, InquiredBy, InquiryType, InquiryCategory, CourseCategory, PriorKnowledge, IndividualType)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        inquiry_values = (new_inquiry_id, new_person_id, inquiry_datetime_obj, inquiry_time_string, 'Open', know_itc_from, 'Application', 'Individual', inquiry_category, interested_course, prior_knowledge, person_type)
        cursor.execute(inquiry_query, inquiry_values)

        connection.commit()
        return jsonify({'status': 'success', 'message': 'Inquiry submitted'}), 200

    except Exception as e:
        logging.exception(f"Error during submission: {e}")
        if connection:
            connection.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500
    finally:
        if connection:
            connection.close()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)


# Old Working Code - But with Mior Errors
# from flask import Flask, jsonify, request
# from flask_cors import CORS
# import pyodbc
# import logging
# from datetime import datetime

# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# app = Flask(__name__)
# CORS(app)

# # Course Data API
# courses = [
#     {
#         'title': 'Accounting',
#         'description': 'Learn accounting principles, financial analysis, and budgeting. Build a foundation for a finance career.',
#         'imageUrl': 'assets/images/accounting.png'
#     },
#     {
#         'title': 'Artificial Intelligence',
#         'description': 'Implement AI solutions, automate tasks, and optimize processes. Drive efficiency with intelligent technology.',
#         'imageUrl': 'assets/images/artificial.webp'
#     },
#     {
#         'title': 'Autodesk',
#         'description': 'Master Autodesk software for 2D/3D modeling in architecture and engineering. Prepare for industry certifications.',
#         'imageUrl': 'assets/images/autodesk.png'
#     },
#     {
#         'title': 'Ethical Hacking',
#         'description': 'Study cryptography, network protocols, and ethical hacking methodologies. Become a guardian of data integrity.',
#         'imageUrl': 'assets/images/ethical_hacking.jpg'
#     },
#     {
#         'title': 'Hardware',
#         'description': 'Gain hardware knowledge: CPUs, motherboards, memory. Learn to assemble and repair systems for IT careers.',
#         'imageUrl': 'assets/images/hardware.jpg'
#     },
#     {
#         'title': 'Multimedia',
#         'description': 'Unleash your creativity through the power of multimedia. Develop your skills in graphics and video editing.',
#         'imageUrl': 'assets/images/multimedia.png'
#     },
#     {
#         'title': 'Cloud Computing & Networking',
#         'description': 'Learn networking concepts, security, and administration. Configure routers and switches for network careers.',
#         'imageUrl': 'assets/images/networking.png'
#     },
#     {
#         'title': 'Data Analysis & Office Automation',
#         'description': 'Master Microsoft Office Suite for document creation, data analysis, and presentations in office environments.',
#         'imageUrl': 'assets/images/data_analysis.png'
#     },
#     {
#         'title': 'Programming',
#         'description': 'Learn programming languages like Python and Java. Develop skills in software and app development.',
#         'imageUrl': 'assets/images/programming.png'
#     },
#     {
#         'title': 'Spoken English',
#         'description': 'Improve spoken English: pronunciation, grammar, vocabulary. Practice for presentations and interviews.',
#         'imageUrl': 'assets/images/spoken_english.png'
#     },
#     {
#         'title': 'Internship',
#         'description': 'Gain practical experience through internships. Apply skills in real-world settings and build your network.',
#         'imageUrl': 'assets/images/internship.jpg'
#     },
#     {
#         'title': 'Other',
#         'description': 'Explore specialized courses like data science and web development. Learn emerging technologies.',
#         'imageUrl': 'assets/images/other.png'
#     },
# ]

# @app.route('/courses', methods=['GET'])
# def get_courses():
#     return jsonify(courses)

# # Database Inquiry API
# SERVER = 'lmsserver-sql.itcmogri.org'
# DATABASE = 'ITC'
# USERNAME = 'itc-app'
# PASSWORD = 'AnoopaM@143'

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
#     connection = None
#     try:
#         connection = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}')
#         cursor = connection.cursor()
#         data = request.get_json()
#         logging.debug(f"Received data: {data}")
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

#         # Convert inquiry_date to datetime
#         try:
#             inquiry_date_obj = datetime.strptime(inquiry_date, '%Y-%m-%dT%H:%M:%S.%f')  # Adjusted format string.
#         except ValueError:
#             return jsonify({'status': 'error', 'message': 'Invalid date format'}), 400

#         # Find the maximum existing PersonId
#         max_person_id_query = "SELECT MAX(PersonId) FROM [ITC].dbo.a_InquiryPersonMaster"
#         cursor.execute(max_person_id_query)
#         max_person_id = cursor.fetchone()[0] or 0
#         new_person_id = max_person_id + 1

#         # Insert into a_InquiryPersonMaster
#         person_query = """
#             INSERT INTO [ITC].dbo.a_InquiryPersonMaster (PersonId, Name, Gender, Mobile, Email, City, PersonType, PersonQualification)
#             VALUES (?, ?, ?, ?, ?, ?, ?, ?)
#         """
#         person_values = (new_person_id, full_name, gender, mobile, email, city, person_type, highest_education)  # Cast person_type to int.
#         cursor.execute(person_query, person_values)

#         # Find the maximum existing InquiryId
#         max_inquiry_id_query = "SELECT MAX(InquiryId) FROM [ITC].dbo.a_InquiryMaster"
#         cursor.execute(max_inquiry_id_query)
#         max_inquiry_id = cursor.fetchone()[0] or 0
#         new_inquiry_id = max_inquiry_id + 1

#         # Insert into a_InquiryMaster
#         inquiry_query = """
#             INSERT INTO [ITC].dbo.a_InquiryMaster (InquiryId, PersonId, InquiryDate, CourseCategory, PriorKnowledge, KnowITCFrom, InquiryType, InquiredBy)
#             VALUES (?, ?, ?, ?, ?, ?, ?, ?)
#         """
#         inquiry_values = (new_inquiry_id, new_person_id, inquiry_date_obj, interested_courses, prior_knowledge, know_itc_from, inquiry_type, 'application')
#         cursor.execute(inquiry_query, inquiry_values)

#         connection.commit()
#         return jsonify({'status': 'success', 'message': 'Inquiry submitted'}), 200

#     except Exception as e:
#         logging.exception(f"Error during submission: {e}")
#         if connection:
#             connection.rollback()
#         return jsonify({'status': 'error', 'message': str(e)}), 500
#     finally:
#         if connection:
#             connection.close()

# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0', port=5000)
