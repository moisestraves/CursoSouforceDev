import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ToastOptions extends LightningElement {

    variants = [
        { label: 'info', value: 'info' },
        { label: 'Success', value: 'success' },
        { label: 'Warning', value: 'warning' },
        { label: 'Error', value: 'error' },

    ]


    //modes = [
    //    { label: 'Dismissable', value: 'dismissable' },
    //  { label: 'Pester', value: 'pester' },
    //  { label: 'Sticky', value: 'sticky' },
    //]

    variant = 'info';
    @api mode;
    @api buttonLabel;

    handlerVariantChange(event) {
        this.variant = event.detail.value;

    }
    handlerLerModeChange(event) {
        this.mode = event.detail.value;
    }
    handlerToastEvent(event) {

        const toast = new ShowToastEvent({
            "title": "Titulo do toast",
            "message": "Mensagem",
            "variant": this.variant,
            "mode": this.mode,
        });

        this.dispatchEvent(toast);
    }
}