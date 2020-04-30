/*
Prototipo del proyecto final - Human-Computer Interaction

Autores:
  * Nicole Continelli
  * Juan S. Obando
  * Luis Martinez
  
API:
  casos en colombia: 
    https://api.thevirustracker.com/free-api?countryTotal=CO
    
    Estructura:
    
      {
         "countrydata":[
            {
               "info":{
                          "ourid":32,
                          "title":"Colombia",
                          "code":"CO",
                          "source":"https://thevirustracker.com/colombia-coronavirus-information-co"
               },
               "total_cases":6211,
               "total_recovered":1411,
               "total_unresolved":0,
               "total_deaths":278,
               "total_new_cases_today":4,
               "total_new_deaths_today":0,
               "total_active_cases":4522,
               "total_serious_cases":118,
               "total_danger_rank":47}],
               "stat":"ok"
             }

*/

// Importing the TUIO library
import TUIO.*;

// Importing HTTP library
import http.requests.*;

// declare a TuioProcessing client
TuioProcessing tuioClient;

enum Gui {
 ESCANEAR,
 MOSTRARINFO,
 MENU
}

// Variables globales
Gui gui;
int numeroCasosColombia = 0, total_recovered = 0, total_unresolved = 0, total_deaths = 0, total_new_cases_today = 0, total_new_deaths_today = 0, total_active_cases = 0, total_serious_cases = 0, total_danger_rank = 0;

// variable para que me muestre info extra o no.
boolean verbose = false;


void setup() {
  //No cursor by default
  noCursor();
  size(800, 800);
  noStroke();
  fill(0);
  gui = Gui.ESCANEAR;
  
  tuioClient = new TuioProcessing(this);
  this.loadDataColombia();
}

void draw() {
  background(0);
  if( gui == Gui.MOSTRARINFO) {
    background(255, 255, 255);
    if (verbose) println("MOSTRANDO INFO");
  }
  else if ( gui == Gui.ESCANEAR){
    background(41,110,13);
    if (verbose) println("ESCANEANDO");
  }
}

void mostrarInfo(String message){
  fill(0, 87, 243);
  text("Hay 2 contagiados cerca de ti", displayWidth/2, displayHeight/2);

}

void loadDataColombia(){
   // Hacer GET Request a API para saber # casos en Colombia
    GetRequest get = new GetRequest("https://api.thevirustracker.com/free-api?countryTotal=CO");
    get.send();
    println(get.getContent());
    println("---------------- ESPACIO------------");
    //Crear Objeto json para poder parsear la info obtenida por el HTTP Request
    JSONObject jsonData = parseJSONObject(get.getContent());
    if(jsonData == null){
      println("JSONObject no se pudo parsear");
    } else {
      //numeroCasosColombia 
      JSONArray countrydata = jsonData.getJSONArray("countrydata");
      JSONObject json = countrydata.getJSONObject(0);
      numeroCasosColombia = json.getInt("total_cases");
      total_recovered = json.getInt("total_cases");
      total_unresolved = json.getInt("total_cases");
      total_deaths = json.getInt("total_cases");
      total_new_cases_today = json.getInt("total_cases");
      total_new_deaths_today = json.getInt("total_cases");
      total_active_cases = json.getInt("total_cases");
      total_serious_cases = json.getInt("total_cases");
      total_danger_rank = json.getInt("total_cases");
      
      println("Numero de casos en Colombia sacado de API:\n" + numeroCasosColombia);
    }
  
}

void addTuioObject(TuioObject tuioObject) {
  println("Objeto: #" + tuioObject.getSymbolID());
  //Si el fiducial 2 entra en la pantalla imprime esto.
  if ( tuioObject.getSymbolID() == 2){
    println("Este objeto será el que imprimirá la info de contagiados cercanos");
    
    //variable global cambia a la gui de mostrar info
    gui = Gui.MOSTRARINFO;
    String contagiados;
  }
}

void removeTuioObject(TuioObject tuioObject){
  if (tuioObject.getSymbolID() == 2) {
      gui = Gui.ESCANEAR;
  }
}
