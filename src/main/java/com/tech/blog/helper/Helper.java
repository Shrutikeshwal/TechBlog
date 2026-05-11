package com.tech.blog.helper;

import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

    public static boolean saveFile(InputStream is, String path) {

        boolean flag = false;

        try {

            byte[] bytes = new byte[is.available()];

            is.read(bytes);

            FileOutputStream fos = new FileOutputStream(path);

            fos.write(bytes);

            fos.flush();

            fos.close();

            flag = true;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return flag;
    }
}
