int out = 12;
int mail = LOW;
int val;

void setup()
{
  pinMode(out, OUTPUT);
  Serial.begin(9600);
  Serial.flush();
}

void loop()
{
  if (Serial.available())
  {
    val = Serial.read();
    if (val == 'Y')
    {
      mail = HIGH;
    }
    else
    {
      mail = LOW;
    }
  }
  
  digitalWrite(out, mail);
}
