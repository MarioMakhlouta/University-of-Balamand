/**
 * The Envelope class represents a specific type of delivery item - an envelope.
 * It extends the DeliveryItem class and adds attributes(dataFields) specific to an envelope.
 */

package deliverycompany;

public class Envelope extends DeliveryItem{
    //data fields extends from the super class: DeliveryItem
    private String size; //the size of the envelope
    
    //constructors:
    public Envelope(){
        this(null, 10000, null, 
                10000, "A2"); //default values of all data fields
    }
    public Envelope(String senderName, String receiverName, 
            int receiverPostalCode, String size){
        this(senderName, 10000, receiverName, 
                receiverPostalCode, size); //default values for the remaining dataFields
    }
    public Envelope(String senderName, int senderPostalCode,String receiverName,
            int receiverPostalCode, String size){
        super(senderName, senderPostalCode, receiverName, receiverPostalCode);
        setSize(size);
        setCost();
    }
    
    //cost setter of the envelope
    private void setCost(){
        double temp;
        if(isInsurance()){
            temp=3.0;
        }
        else{
            temp=0.0;
        }
        switch(getSize()){
            case "A2": super.setCost(2.0+temp); break;
            case "A6": super.setCost(1.6+temp); break;
            case "A7": super.setCost(1.5+temp); break;
            case "A9": super.setCost(1.2+temp); break;
            case "4square": super.setCost(1.8+temp); break;
            case "5square": super.setCost(1.6+temp); break;
        }     
    }

    //setter of size
    public void setSize(String size){
        switch(size){
            case "A2":
            case "A6":
            case "A7":
            case "A9":
            case "4square":
            case "5square": 
                this.size = size;
                break;
            default:
                this.size = "A2";      
        }
    }
    //getter of the size
    public String getSize() {
        return size;
    }
    
    //overrided toString:
    @Override
    public String toString() {
        return "Envelope: "+getSerialNumber()+" - "+getDate()
                +"\nSize: "+size
                +"\nSender: "+getSenderName()+" - "+getSenderPostalCode()
                +"\nReceiver: "+getReceiverName()+" - "+getReceiverPostalCode()
                +"\n"+(isInsurance()?"With ":"Without ")+"insurance"
                +"\nStatus: "+(getStatus()==DeliveryItem.RECEIVED?"Receiver":
                (getStatus()==DeliveryItem.ASSIGNED?"Assigned":"Delivered"))
                +"\nCost: "+getCost()+"$";
    }
}