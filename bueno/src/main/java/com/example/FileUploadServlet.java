package com.example;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    Part filePart = request.getPart("fastaFile");
      StringBuilder fileContent = new StringBuilder();
       String firstLine = null;
       boolean isFirstLine = true; 
            try (InputStream fileInputStream = filePart.getInputStream();
                 Scanner scanner = new Scanner(fileInputStream)) {
                while (scanner.hasNextLine()) {
                    String line = scanner.nextLine();        
                    if (isFirstLine) {
                        firstLine = line;
                        isFirstLine = false;
                        continue;
                    }                    
                    fileContent.append(line.replaceAll("\\s+", ""));
                }
            }
        
       String oneLineOfSequences = fileContent.toString();
       request.setAttribute("fileContent", oneLineOfSequences);
       request.setAttribute("firstLine", firstLine); 
       RequestDispatcher dispatcher = request.getRequestDispatcher("/NewFile.jsp");
       dispatcher.forward(request, response);
    }
}


