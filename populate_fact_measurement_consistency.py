import mysql.connector
import random

connection = mysql.connector.connect(user='user',
                              password='password',
                              host='127.0.0.1',
                              database='dq')

cursor = connection.cursor()

measurements = {}

# Construct a scenario where quality of data is poor in Lending system for
# Legal Entity Customer Collateral Addres starting in October 2023
drop_date_id = 9
drop_role_id = 1
drop_party_id = 2
drop_address_purpose_id = 2
drop_place_id = [2, 4]
drop_system_id = [1, 2, 3, 4, 5]

for date_id in range(1, 13):

    print(f'Populating date id: {date_id}.')

    for role_id in range(1,4):
        for party_id in range(1,3):
            for address_purpose_id in range(1,3):
                for place_id in range(1,5):
                    for system_id in range(1,6):
    
                        measurement_consistency_key = (role_id, party_id, address_purpose_id, place_id, system_id, 0, 0)

                        if measurement_consistency_key in measurements:
                            if date_id == drop_date_id and \
                                    role_id == drop_role_id and \
                                    party_id == drop_party_id and \
                                    address_purpose_id == drop_address_purpose_id and \
                                    place_id in drop_place_id and \
                                    system_id in drop_system_id:
                                measurement_consistency_delta = random.uniform(-0.7, -0.5)
                            else:
                                measurement_consistency_delta = random.uniform(-0.05, 0.05)
                            consistency_current = measurements[measurement_consistency_key]
                            if consistency_current + measurement_consistency_delta > 1.0:
                                measurements.update({measurement_consistency_key: 1.0 })
                            elif consistency_current + measurement_consistency_delta < 0.0:
                                measurements.update({measurement_consistency_key: 0.0 })                            
                            else:
                                measurements.update({measurement_consistency_key: consistency_current + measurement_consistency_delta })
                        else:
                            measurement_consistency_initial = random.uniform(0.8, 0.9)
                            measurements[measurement_consistency_key] = measurement_consistency_initial

                        measurement_consistency_data = {
                            'measurement': measurements[measurement_consistency_key], 
                            'date_id': date_id,
                            'concept_role_id': role_id,
                            'concept_party_id': party_id,
                            'concept_address_purpose_id': address_purpose_id,
                            'concept_place_id': place_id,
                            'container_system_id': system_id,
                            'container_relational_id': 0,
                            'container_xml_id': 0
                        }

                        add_measurement_consistency = ("INSERT INTO fact_measurement_consistency "
                                        "(measurement, date_id, concept_role_id, concept_party_id, concept_address_purpose_id, concept_place_id, container_system_id, container_relational_id, container_xml_id)"
                                        "VALUES (%(measurement)s, %(date_id)s, %(concept_role_id)s, %(concept_party_id)s, %(concept_address_purpose_id)s, %(concept_place_id)s, %(container_system_id)s, %(container_relational_id)s, %(container_xml_id)s)")

                        cursor.execute(add_measurement_consistency, measurement_consistency_data)
                        
                        fact_measurement_consistency_id = cursor.lastrowid
                        print(f'Last row id: {fact_measurement_consistency_id}.')

connection.commit()

connection.close()