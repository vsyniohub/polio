import { api, LightningElement } from 'lwc';

export default class CheckBoxItem extends LightningElement {
    @api item;

    selectionClicked(event) {
        this.dispatchEvent(
            new CustomEvent("clicked", { detail: this.item.id })
        );
    }
}