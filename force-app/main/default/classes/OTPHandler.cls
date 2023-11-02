public class OTPHandler implements CodeGenerateInterface {
    OTPHandler instance;
    
    public OTPHandler getInstance() {
        if (this.instance == null) {
            this.instance = new OTPHandler();
        }
        return this.instance;
    }
    public String generateCode(){
        return generateCodeByCrypto();
    }
    
    private String generateCodeByCrypto() { //generates simple integer random value
        return String.valueOf(Crypto.getRandomInteger());
    }
}