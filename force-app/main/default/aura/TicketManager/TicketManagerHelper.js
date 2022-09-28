({
    loadVoos: function(component, aeroportoOrigem, aeroportoDestino, dataPartida, dataRetorno) {

        let action = component.get('c.getVoos');

        //String aeroportoOrigem, String aeroportoDestino, String dataPartida, String dataRetorno
        action.setParam('aeroportoOrigem', aeroportoOrigem);
        action.setParam('aeroportoDestino', aeroportoDestino);
        action.setParam('dataPartida', dataPartida);
        action.setParam('dataRetorno', dataRetorno);

        action.setCallback(this, function(result) {
            let state = result.getState();

            if (state == 'SUCESS') {
                component.set('v.voos', getReturnValue());
            } else if (state == 'ERROR') {
                windows.console.error(result.getError());
            }
        });

    }
})