public with sharing class CotacaoServices {
  
    //Criação do metodo que faz requisição do HTTP REQUEST E RESPONSE "Local onde Passa a url de acesso "
    private final static String serviceUrl = 'https://economia.awesomeapi.com.br/json/daily/{origem}-BRL/15';
   
    public static List<Cotacao> getCotacao(String moedaOrigem){
                //* Primeiro Criar o endpoint, que é o serviço que vamos consumir

                String endpoint = serviceUrl.replace('{origem}',moedaOrigem); // passagem de param no endpoint


                // chamada da conexão HTTP é feita uma nova istância 
                HTTP http = new HTTP();
                // Chamada da requisição 
                HttpRequest request = new HttpRequest();
                
                // Passo dentro do corpo da requisição passar o enpoint na requisição
                request.setEndpoint(endpoint);
                request.setMethod('GET'); // Verbo da requisição
                request.setTimeout(1200); // Passagem de tempo da requição é opcional
                // Usado quando precisamos passar um autenticação na requisição
                request.setHeader('Content-Type','application/json'); 

                //O response vem do meu http request
                HttpResponse response = http.send(request); 

                // verificação da requisição a resposta
                if(response.getStatusCode() == 200){

                    String jsonString = response.getBody();

                    return Cotacao.parse(jsonString); // retorno do valores da cotação

                }else{
                    // Usamos o map quando podemos ter varios tipos de retorno e usamos Objects 
                    Map <String, Object> error = new Map <String, Object>();

                    error.put('StatusCode',response.getStatusCode());
                        
                    error.put('Status',response.getStatus());
                        
                    error.put('Body',response.getBody());

                    throw  new CotacaoServicesException(JSON.serialize(error)); // gerando error na resposta
                    
                }

    }

    public void test(){
        List <Cotacao> result = CotacaoServices.getCotacao('USD');
        System.Debug(result);
    }
    
     public class CotacaoServicesException extends Exception {}
}