public with sharing class Cotacao {
   
public String code ;              //Moeda Origem   
public String codein;            // Moeda destino 
public String name;             // Nome da Moeda 
public String high;            //Máximo  
public String low;            //Minimo
public String varBid;        // variação   
public String pctChange;    // % de variação
public String bid;         //Compra 
public String ask;        //Venda
public String timestamp; // hora da cotação
public String create_date; //Data da cotação

//Metodo que esta criando uma lista para cotação, usando o retorno do Json
public static List <cotacao> parse(String jsonString) {

    return (List<cotacao>)JSON.deserialize(jsonString, List<cotacao>.class);
}

}