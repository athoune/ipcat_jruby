package org.ipcat;

import java.util.regex.Pattern;

public class IP {

    public static long  parseIp(String address) {
        long result = 0;

        for(String part : address.split(Pattern.quote("."))) {
            result = result << 8;
            result |= Long.parseLong(part);
        }
        return result;
    }
}
