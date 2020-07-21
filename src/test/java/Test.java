import org.springframework.util.DigestUtils;

import java.text.ParseException;

public class Test {
    public static void main(String[] args) throws ParseException {
        Test test = new Test();
        for (int i = 0; i < 12; i++) {
            test.getMd5("123456", test.getSlat());
        }
    }

    private String getSlat() {
        String all = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuffer sb = new StringBuffer(16);
        for (int i = 0; i < 16; i++) {
            sb.append(all.charAt((int) (Math.random() * all.length())));
        }
        return sb.toString();
    }

    private String getMd5(String password, String slat) {
        String s = password + slat;
        String md5 = DigestUtils.md5DigestAsHex(s.getBytes());

        System.out.print(slat);
        System.out.println(" " + md5);
        return md5;
    }
}
