import { api, LightningElement, track, wire } from 'lwc';
import sendMessage from '@salesforce/apex/ApexToAgentforceConnect.invoke';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import { getRecord } from 'lightning/uiRecordApi';

export default class chatWithAgentforce extends LightningElement {
    @track userInput = '';
    @track sessionId = '';
    @api recordId;
    @track flag = true; // Flag to control visibility of chat section
    @track conversation = [];
    @track usermessages = [];
    handleInputChange(event) {
        this.userInput = event.target.value;
    }
    @track name;

    @wire(getRecord, { recordId: USER_ID, fields: [NAME_FIELD] })
    loadUser({ error, data }) {
        if (data) {
            this.name = data.fields.Name.value;
        } else if (error) {
            console.error('Failed to load user', error);
        }
    }
    async connectedCallback() {
        /*try {
            const response = await sendMessage({
                userMessage: 'Can you please create a Account plane for '+this.recordId,
                sessionId: this.sessionId,
                accountId: this.recordId
            });
            this.sessionId = response.sessionId;
            this.conversation.push(
                `Agentforce: ${response.agentResponse
                    .replace(/\\n+/g, "\n")
                    .replace(/\\/g, "")
                    .trim()}`
            );
        } catch (error) {
            console.error('Error communicating with Agentforce:', error);
            this.conversation.push('Agentforce: Sorry, something went wrong.');
        } */
       this.conversation.push('Agentforce: Hello, I am Agentforce! How can I assist you today?');
    }
    async handleSendMessage() {
        if (!this.userInput.trim()) return;
        const userMessage = this.userInput.trim();
        console.log(this.userInput,' entered input');
        
        this.conversation.push(`User: ${userMessage}`);
        console.log(this.conversation,' user messages');
        this.userInput = '';
        try {
            const response = await sendMessage({
                userMessage: userMessage,
                sessionId: this.sessionId,
                accountId: this.recordId
            });
            this.sessionId = response.sessionId;
            this.conversation.push(
                `Agentforce: ${response.agentResponse
                    .replace(/\\n+/g, "\n")
                    .replace(/\\/g, "")
                    .trim()}`
            );
        } catch (error) {
            console.error('Error communicating with Agentforce:', error);
            this.conversation.push('Agentforce: Sorry, something went wrong.');
        } 
    }

    // <-- NEW: parse each string into { isUser, isAgentforce, text }
    get parsedConversation() {
        return this.conversation.map((msg, idx) => {
            const [prefix, ...rest] = msg.split(':');
            const text = rest.join(':').trim();
            const role = prefix.trim();
            return {
                id: idx,
                text,
                isUser: role === 'User',
                isAgentforce: role === 'Agentforce'
            };
        });
    }
}