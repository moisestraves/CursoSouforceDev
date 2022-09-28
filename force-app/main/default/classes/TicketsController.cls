public with sharing class TicketsController {
   @AuraEnabled
      public static List<Aeroporto__c> getAeroportos(String search){
        search += '%';
        
        return [SELECT ID,Estado__r.Name ,Sigla__c
        FROM Aeroporto__c 
        WHERE Name Like :search OR 
        Estado__r.Name LIKE : search OR
        Sigla__c LIKE :search
        with SECURITY_ENFORCED
        ];
    }

    //2022-03-28
    public static Date dataParse(String dateString){
        List<String> dt = dateString.split('-');
        Date dtResult = Date.newInstance(Integer.valueOf(dt.get(0)),Integer.valueOf(dt.get(1)),Integer.valueOf(dt.get(2)));

        return dtResult;
    }
    @AuraEnabled
    public static List<RetornoVooTo> getVoos(String aeroportoOrigem, String aeroportoDestino, String dataPartida, String dataRetorno){
       Date dtPartida = dataParse(dataPartida);
       Date dtRetorno = dataParse(dataRetorno);

       List<Voo__C> voosOrigem = [SELECT id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c,
                                         Duracao__c, Companhia__c,Hora_de_Partida__c, Hora_de_Chegada__c, Data_Partida__c, Data_Chegada__c
                                    FROM Voo__C 
                                    WHERE Data_Partida__c =:dtPartida AND Aeroporto_Partida__c =: aeroportoOrigem AND Aeroporto_Chegada__c =:aeroportoDestino
                                    WITH SECURITY_ENFORCED];

       List<Voo__C> voosDestino = [SELECT id, Name, Aeroporto_Chegada__r.Sigla__c, Aeroporto_Partida__r.Sigla__c, Valor__c,
                                          Duracao__c, Companhia__c,Hora_de_Partida__c, Hora_de_Chegada__c, Data_Partida__c, Data_Chegada__c
                                    FROM Voo__C 
                                    WHERE Data_Partida__c =:dtRetorno AND Aeroporto_Partida__c =: aeroportoDestino AND Aeroporto_Chegada__c =:aeroportoOrigem
                                    WITH SECURITY_ENFORCED];
                                    
       List<RetornoVooTo > result = new List<RetornoVooTo>();  
       for(Voo__c vooOrigem: voosOrigem){
           for(Voo__c vooDestino: voosDestino){
               result.add(new RetornoVooTo(vooOrigem,vooDestino));

           }
       }  
       return result;
       
    }
    
    @AuraEnabled
    public static Ticket__c creatTicket (String accountId, String vooIdaId, String vooVoltaId){
        if(Schema.SObjectType.Ticket__c.isCreateable()){
        Ticket__c ticket = new Ticket__c();

        if(Schema.SObjectType.Ticket__c.fields.Account__c.isCreateable()){
        ticket.Account__c = accountId;
        }
        if(Schema.SObjectType.Ticket__c.fields.Voo_Ida__c.isCreateable()){
        ticket.Voo_Ida__c = vooIdaId;
        }

         if(Schema.SObjectType.Ticket__c.fields.Voo_Volta__c.isCreateable()){
        ticket.Voo_Volta__c = vooVoltaId;
        }

        insert ticket;
        return ticket;
} else {
    throw new AuraHandledException('Você não tem permissão para criar um ticket, contate o Administrador');

    }
  }
  public class RetornoVooTo{
      @AuraEnabled
      public Voo__C vooIda;
      @AuraEnabled
      public Voo__C voovolta;

      public RetornoVooTo(Voo__C vooIda, Voo__C voovolta){
          this.vooIda = vooIda;
          this.voovolta = voovolta;
      }
      
  }
}