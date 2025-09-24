#define output1 54
#define output2 55
#define input1 56 // robot signal

String incomingByte; 

// This code is usefull when using buttons instead of keyboard input :

// #define PIN_D 57 // buton for A
// #define PIN_E 58 // buton for B

void setup() {

  //init all pinMode
  pinMode(output1, OUTPUT);
  pinMode(output2, OUTPUT);
  pinMode(input1, INPUT);

  // This code is usefull when using buttons instead of keyboard input :
  //pinMode(PIN_D, INPUT);
  //pinMode(PIN_E, INPUT);
  
  Serial.begin(9600);

}

void send_to_robot(int pin)
{
  digitalWrite(pin, HIGH);
  while (!digitalRead(input1)); //wait for robot response
  digitalWrite(pin, LOW);
  Serial.print("Done\n");
}

void send_to_robot_home_and_learning_mode()
{
  digitalWrite(output2, HIGH);
  digitalWrite(output1, HIGH);
  while (!digitalRead(input1)); //wait for robot response
  digitalWrite(output2, LOW);
  digitalWrite(output1, LOW);
  Serial.print("Done\n");
}

void loop() {

  // This code is usefull when using keyboard input instead of buttons :
  Serial.flush();
  delay(1000);

  incomingByte = Serial.readString();
  if (incomingByte.length() != 0){
    if(incomingByte == "pick"){
      Serial.println("sending "+ incomingByte);
      send_to_robot(output1);
    }

    else if (incomingByte == "place"){
      Serial.println("sending "+ incomingByte);
      send_to_robot(output2);
    }
    else if (incomingByte == "finish"){
      Serial.println("sending "+ incomingByte);
      send_to_robot_home_and_learning_mode();
    }
  }

// This code is usefull when using buttons instead of keyboard input :

//  int val_D = digitalRead(PIN_D);
//  int val_E = digitalRead(PIN_E);
//  
//  if (val_D && !val_E) { // if only D is push
//    Serial.print("sending A\n");
//    send_to_robot(PIN_A);
//  } else if (!val_D && val_E) { //if only E is push
//    Serial.print("sending B\n");
//    send_to_robot(PIN_B);
//  }

  
}
