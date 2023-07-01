# Salon-Appointment-Scheduler
This script is designed to assist customers in scheduling appointments for services at My Salon. The script prompts users for their service preferences, contact information, and preferred appointment time. It interacts with a PostgreSQL database to retrieve available services, check service availability, and insert appointment details.
# Script Overview
The script begins by displaying the salon name and main menu prompt, providing a welcoming introduction to the salon experience.

Next, the script retrieves the available services from the database. If there are no services available, the program exits with a message indicating the unavailability of services at the moment.

In the case of available services, the script proceeds to display the list of services to the user, creating an interactive menu. The user is prompted to select a service by entering the corresponding number. If the user input is not a valid number, an error message is displayed, and the user is returned to the main menu to make a valid selection.

Once a valid service selection is made, the script checks the availability of the chosen service. If the service is not available, an error message is displayed, and the user is returned to the main menu to choose another service.

The script then prompts the user for their phone number. It checks whether the customer is already registered in the database. If the customer is not found, the user is prompted to provide their name, and a new customer record is inserted into the database with the provided name and phone number.

Next, the user is prompted to enter the desired appointment time. The script retrieves the customer ID from the database based on the phone number provided. Using the gathered information, the appointment details, including the service ID, customer ID, and appointment time, are inserted into the database.

If the appointment is successfully scheduled, a confirmation message is displayed, acknowledging the booking of the service at the specified time for the customer. However, if the appointment fails to schedule, an error message is displayed, indicating that the user should try again later.
