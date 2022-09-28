({
    init: function(component, event, helper) {

        let aeroportoOrigem = 'a0O5f000003pccJEAQ';
        let aeroportoDestino = 'a0O5f000003pccLEAQ';
        let dataPartida = '2021-1-10';
        let dataRetorno = '2022-1-15';

        helper.loadVoos(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno);
    }
})