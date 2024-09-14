/**
 * The Package class represents a specific type of delivery item - a package.
 * It extends the DeliveryItem class and adds attributes(dataFields) specific to a package.
 */

package deliverycompany;

public class Package extends DeliveryItem{
    //data fields extends from the super class: DeliveryItem
    private double height; //height of the package
    private double width; //width of the package
    private double length; //length of the package
    private double volume; //volume of the package
    private double weight; //weight of the package
    
    //construtors:
    public Package(){
        this(null, 10000, null, 
                10000,0.2, 0.2, 0.2, 0.1); //default values of all data fields
    }
    public Package(String senderName, String receiverName, int receiverPostalCode, 
            double height, double width, double length, double weight){
        this(senderName, 10000, receiverName, receiverPostalCode,
                height, width, length, weight); //default values for the remaining dataFields
    }
    public Package(String senderName, int senderPostalCode,String receiverName, 
            int receiverPostalCode,double height, double width, 
            double length, double weight){
        super(senderName, senderPostalCode, receiverName, receiverPostalCode);
        setPackage(height, width, length, weight);
        setVolume();
        setCost();
    }
    
    //setObject:
    private void setPackage(double height, double width, 
            double length, double weight){
        setHeight(height);
        setWidth(width);
        setLength(length);
        setWeight(weight);
    }

    //setter for dataFields of subClass:
    private void setHeight(double height) {
        if(height>0)
            this.height = height;
        else
            this.height = 0.2; //default value of height
    }
    private void setWidth(double width) {
        if(width>0)
            this.width = width;
        else
            this.width = 0.2; //default value of width
    }
    private void setLength(double length) {
        if(length>0)
            this.length = length;
        else
            this.length = 0.2; //default value of length
    }
    private void setWeight(double weight) {
        if(weight>0)
            this.weight = weight;
        else
            this.weight = 0.1; //default value of weight
    }
    
    //cost setter of the package
    private void setCost(){
        double temp;
        if(isInsurance()){
            temp=20*weight;
        }
        else{
            temp=0.0;
        }
        
        if(volume<=2){
            super.setCost((2.0+3*weight)+temp);
        }
        else if(volume<=5){
            super.setCost((2.8+3*weight)+temp);
        }
        else{
            super.setCost((2.8+3*weight+5*(volume-5))+temp);
        }
    }
    //volume setter of the package
    private void setVolume(){
        volume = height*width*length;
    }
    
    //getters for all data fields in this subClass:
    public double getHeight() {
        return height;
    }
    public double getWidth() {
        return width;
    }
    public double getLength() {
        return length;
    }
    public double getVolume() {
        return volume;
    }
    public double getWeight() {
        return weight;
    }
    
    //overrided toString:
    @Override
    public String toString() {
        return "Package: "+getSerialNumber()+" - "+getDate()
                +"\nDimension: "+height+"*"+width+"*"+length
                +"\nVolume: "+volume+" - Weight: "+weight
                +"\nSender: "+getSenderName()+" - "+getSenderPostalCode()
                +"\nReceiver: "+getReceiverName()+" - "+getReceiverPostalCode()
                +"\n"+(isInsurance()?"With ":"Without ")+"insurance"
                +"\nStatus: "+(getStatus()==DeliveryItem.RECEIVED?"Receiver":
                (getStatus()==DeliveryItem.ASSIGNED?"Assigned":"Delivered"))
                +"\nCost: "+getCost()+"$";
    }
}