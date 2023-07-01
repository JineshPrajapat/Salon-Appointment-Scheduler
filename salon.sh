#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then 
    echo -e "\n$1"
  fi

  echo -e "\nWelcome to My Salon, how can I help you?"
  # get available service
    AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services;")
  # if not available service
    if [[ -z $AVAILABLE_SERVICES ]]
    then
    # exit the program
      EXIT "Sorry, services are not available right now."
    else
    # dispaly services
      echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
      do
        echo "$SERVICE_ID) $SERVICE_NAME"
      done

    # ask for services
      echo -e "\nWhich services you needed?"
      read SERVICE_ID_SELECTED
    # if input is not number
      if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
      then
        MAIN_MENU "I could not find that service. What would you like today?"
      else
      # checking service availability
        SERVICE_AVAILABILITY=$($PSQL "SELECT service_id FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
        if [[ -z $SERVICE_AVAILABILITY ]]
        then
          MAIN_MENU "The selected service does not exist, select again:"
        else
        
          SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
        # get customer info
          echo -e "\nWhat's your phone number?"
          read CUSTOMER_PHONE
          CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE' ")
        # if customer not found
          if [[ -z $CUSTOMER_NAME ]]
          then
          # get customer name
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            INSERTED_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
          fi
          
        # time enquiry
          echo -e "\nWhat time would you like your$SERVICE_NAME,$CUSTOMER_NAME"
          read SERVICE_TIME

        # get customer id
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
        # insert to appointment]
          INSERT_INTO_APPOINTMENT=$($PSQL "INSERT INTO appointments(service_id,customer_id, time) VALUES($SERVICE_ID_SELECTED,$CUSTOMER_ID,'$SERVICE_TIME') ") 
          if [[ $INSERT_INTO_APPOINTMENT == 'INSERT 0 1' ]]
          then
            echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
          else 
            MAIN_MENU "The appointment could not be scheduled at this time. Please try again later."
          fi
        fi
      fi
    fi
}

EXIT(){
  if [[ $1 ]]
  then 
    echo -e "\n$1"
  fi
  echo "Thank you for choosing our services."
}

MAIN_MENU

