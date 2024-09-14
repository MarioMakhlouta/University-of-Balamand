/**
 * The DeliveryItem class is an abstract class representing an item to be delivered.
 * It encapsulates common attributes and methods shared by its subclasses Envelope and Package.
 */

package deliverycompany;

import java.util.Date; // library/package to use in this Class

public class DeliveryItem {
    //data fields:
    private static int serialGenerator = 1000;
    private int serialNumber; //serial number of the delivered item
    private Date date; //date of receiving item
    private char status; //status of delivery: received, assigned, delivered
    private String senderName; //name of the item sender 
    private String receiverName; //name of the item receiver
    private int senderPostalCode; //post code of the item sender
    private int receiverPostalCode; //post code of the item receiver
    private double cost; //cost of the item with/without insurance
    private boolean insurance; //if the item has an insurance or not
    
    //values for status:
    public static final char RECEIVED = 'R';
    public static final char ASSIGNED = 'A';
    public static final char DELIVERED = 'D';
            
    //Constructors:
    public DeliveryItem(){
        this(null,10000,null,10000); //default values of all data fields
    }
    public DeliveryItem(String senderName, String receiverName, 
            int receiverPostalCode){
        this(senderName,10000, receiverName,receiverPostalCode); //default values for the remaining dataFields
    }
    public DeliveryItem(String senderName, int senderPostalCode,
            String receiverName, int receiverPostalCode){
        serialNumber = serialGenerator; 
        serialGenerator++; //increment for each new item
        date = new Date(); //machine time
        setStatus(DeliveryItem.RECEIVED);
        setDeliveryItem(senderName, senderPostalCode, 
                receiverName, receiverPostalCode);
        setCost(2.0); //default value
        insurance = false; //default value
    }
    
    //setObject:
    private void setDeliveryItem(String senderName, int senderPostalCode,
            String receiverName, int receiverPostalCode){
        setSenderName(senderName);
        setSenderPostalCode(senderPostalCode);
        setReceiverName(receiverName);
        setReceiverPostalCode(receiverPostalCode);
    }
    
    //getters: (for all non-static dataFields)
    public int getSerialNumber() {
        return serialNumber;
    }
    public Date getDate() {
        return date;
    }
    public char getStatus() {
        return status;
    }
    public String getSenderName() {
        return senderName;
    }
    public String getReceiverName() {
        return receiverName;
    }
    public int getSenderPostalCode() {
        return senderPostalCode;
    }
    public int getReceiverPostalCode() {
        return receiverPostalCode;
    }
    public double getCost() {
        return cost;
    }
    public boolean isInsurance() {
        return insurance;
    }
    
    //setters:
    private void setSenderName(String senderName){
        this.senderName = senderName;
    }
    private void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }
    private void setSenderPostalCode(int senderPostalCode) {
        if(senderPostalCode>0)
            this.senderPostalCode = senderPostalCode;
        else
            this.senderPostalCode = 10000; //default value
    }
    private void setReceiverPostalCode(int receiverPostalCode) {
        if(receiverPostalCode>0)
            this.receiverPostalCode = receiverPostalCode;
        else
            this.receiverPostalCode = 10000; //default value
    }

    public void setStatus(char status) {
        switch(status){
            case 'R':
            case 'A':
            case 'D': 
                this.status = status;
                break;
            default:
                this.status = DeliveryItem.RECEIVED; //default value of status
        }
    }
    public void setCost(double cost){  
        this.cost = cost; 
    }
    
    //methods:
    public void addInsurance(){
        this.insurance = true; //add insurance
        cost += 3;
    }
    public void cancelInsurance(){
        this.insurance = false; //remove insurance
        cost -= 3;
    }
    
    //overrided toString:
    @Override
    public String toString() {
        return serialNumber+" - "+date
                +"\nSender: "+senderName+" - "+senderPostalCode
                +"\nReceiver: "+receiverName+" - "+receiverPostalCode
                +"\n"+(isInsurance()?"With ":"Without ")+"insurance"
                +"\nStatus: "+(status==DeliveryItem.RECEIVED?"Receiver":
                (status==DeliveryItem.ASSIGNED?"Assigned":"Delivered"));
    }
}