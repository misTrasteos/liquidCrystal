#include <LiquidCrystal.h>

// a este sensor analógico, conecto la patilla central del sensor de temperatura
byte sensorTMP36Pin = A5;

// inicio la librería liquidCrystal con los siguientes pines
/*
  pin RS
  pin ENABLE
  pines de datos
*/
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// cadenas de texto, ¿dónde es mejor definirlas? 
// http://learn.adafruit.com/memories-of-an-arduino
String sActual = "Actual: ";
String sMaximo = "Máximo: ";
String sMinimo = "Mínimo: ";
String sMedia = "Media: " ;

float maximo = -999;
float minimo = 999;
float media = 0;

void setup() {
  lcd.begin(40, 2); // columnas x filas de la pantalla
}//setup

void loop(){
  delay(1000);

  // obtengo el valor del tmp36 y lo transformo a grados
  unsigned int valorSensorTMP36 = analogRead(sensorTMP36Pin);  
  float miliVoltios = (valorSensorTMP36 * 5000.0) / 1024.0;
  float grados = (miliVoltios-500.0)/10.0;

  // actualizo el máximo, el mínimo y la media
  if(grados>maximo) maximo = grados;   
  if(grados<minimo) minimo = grados;

  if(media==0) media = grados;
  else media = (media+grados)/2;

  //muestro los valores por pantalla
    
  lcd.setCursor(0,0);
  lcd.print( sActual );
  lcd.print( grados );

  lcd.setCursor(20,0);
  lcd.print( sMedia );
  lcd.print( media );

  lcd.setCursor(0,1);
  lcd.print( sMinimo );
  lcd.print( minimo );  

  lcd.setCursor(20,1);
  lcd.print( sMaximo );
  lcd.print( maximo );
}//loop