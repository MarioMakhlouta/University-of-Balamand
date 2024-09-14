/**
 * The Driver class represents a delivery driver.
 * It has a DeliveryItem as a composition.
 */

package deliverycompany;

import java.util.ArrayList;  // importing the library/package to use in this Class

public class Driver {
    //data fields:
    private String name; //name of the driver
    private int [] zone; //the zone covered by the driver
    private ArrayList<DeliveryItem> deliveries; //array of items to deliver
    private String carRegistrationNb; //registration number of the driver's car
    private double maxWeight; //max weight that the driver can handle in the same time
    private double maxVolume; //max volume that the driver can handle in the same time
    private double currentWeight; //total weight of items currently handled by the driver
    private double currentVolume; //total volume of items currently handled by the driver
    
    //constructors:
    public Driver(){
        this("", "", 500, 
                50, new int[]{10000, 50000}); //default values of all data fields
    }
    public Driver(String name){
        this(name, "", 500, 
                50, new int[]{10000, 50000}); //default values for the remaining dataFields
    }
    public Driver(String name, String carRegistrationNb, double maxWeight, 
            double maxVolume, int [] zone){
        setDriver(name, carRegistrationNb, maxWeight, maxVolume, zone);
    }
    
    //setObject:
    public void setDriver(String name, String carRegistrationNb, 
            double maxWeight, double maxVolume, int [] zone){
        int [] array = new int [2];
        array = zone;
        setName(name);
        setCarRegistrationNb(carRegistrationNb);
        setMaxWeight(maxWeight);
        setMaxVolume(maxVolume);
        setZone(array);
        deliveries = new ArrayList();
    }
    
    //getters:
    public String getName() {
        return name;
    }
    public int[] getZone() {
        return zone;
    }
    public ArrayList<DeliveryItem> getDeliveries() {
        return deliveries;
    }
    public String getCarRegistrationNb() {
        return carRegistrationNb;
    }
    public double getMaxWeight() {
        return maxWeight;
    }
    public double getMaxVolume() {
        return maxVolume;
    }
    public double getCurrentWeight() {
        return currentWeight;
    }
    public double getCurrentVolume() {
        return currentVolume;
    }
    
    //setters:
    public void setName(String name) {
        this.name = name;
    }
    public void setZone(int[] zone) {
        if(zone.length>2)
            this.zone = new int[]{10000, 50000};
        else
            this.zone = zone;
    }
    public void setCarRegistrationNb(String carRegistrationNb) {
        if(Character.isLetter(carRegistrationNb.charAt(0)) 
                && Character.isUpperCase(carRegistrationNb.charAt(0)))
            this.carRegistrationNb = carRegistrationNb;
        else
            this.carRegistrationNb = ""; //default value
    }
    public void setMaxWeight(double maxWeight) {
        if(maxWeight>0)
            this.maxWeight = maxWeight;
        else
            this.maxWeight = 500; //default value
    }
    public void setMaxVolume(double maxVolume) {
        if(maxVolume>0)
            this.maxVolume = maxVolume;
        else
            this.maxVolume = 50; //default value
    }
    
    //methods:
    //assign a delivery to a driver:
    public boolean assignDelivery(DeliveryItem item){
        if(item.getReceiverPostalCode()>=zone[0] && 
                item.getReceiverPostalCode()<=zone[1] && 
                currentWeight<maxWeight && currentVolume<maxVolume){
            deliveries.add(item);
            currentWeight += ((Package)item).getWeight(); //explicit casting to use method of the subClass Package
            currentVolume += ((Package)item).getVolume();
            return true;
        }
        return false;
    }
    //if accomplish this delivery asigned to the driver:
    public boolean accomplishDelivery(int serialNb){
        for(int i=0; i<deliveries.size(); i++){
            if(deliveries.get(i).getSerialNumber() == serialNb){
                deliveries.remove(deliveries.get(i));
                currentWeight -= ((Package)deliveries.get(i)).getWeight();
                currentVolume -= ((Package)deliveries.get(i)).getVolume();
                return true;
            }    
        }
        return false;
    }
    
    //overrided toString:
    @Override
    public String toString() {
        return name
                +"\nActive Zone: ["+zone[0]+"-"+zone[1]+"]"
                +"\nCar: "+carRegistrationNb
                +"\nMax Weight: "+maxWeight+" - Max Volume "+maxVolume;
    }
}