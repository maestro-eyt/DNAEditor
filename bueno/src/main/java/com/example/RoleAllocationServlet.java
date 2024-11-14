package com.example;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.sbolstandard.core3.api.SBOLAPI;
import org.sbolstandard.core3.entity.Component;
import org.sbolstandard.core3.entity.SBOLDocument;
import org.sbolstandard.core3.io.SBOLFormat;
import org.sbolstandard.core3.io.SBOLIO;
import org.sbolstandard.core3.util.SBOLGraphException;
import org.sbolstandard.core3.vocabulary.ComponentType;
import org.sbolstandard.core3.vocabulary.Role;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.net.URI;

public class RoleAllocationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String newSplit = request.getParameter("allSequences");

        
        newSplit = newSplit.replace("\"", "").replace(":", "").replace("[", "").replace("]", "").replace(" ", "");        
        String[] sequences = (newSplit.split(","));
     
        SBOLDocument doc = new SBOLDocument();
     
        
       String theTitleofFile = (String) request.getAttribute("firstLine");
       
       
        for (int i=0; i<sequences.length;i++) {
        	
         String[] sequencesAray = (sequences[i].split("Sequence"));
         //System.out.println("here");
         //System.out.println(i);
        System.out.println(sequencesAray[i]);
       ;
        int j;
        try {
        
        	
        	URI creation= URI.create("http://sys-bio.org/"+"_"+ sequencesAray[i]); // basically if there are 2 of the same roles the URI will be diff.
        	 doc.setBaseURI(creation);
           
        	 switch (sequencesAray[0]) {
             case "CDS":
                 Component CDS = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.CDS, sequencesAray[1]);
                 break;
             case "Effector":
                 Component Effector = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.Effector, sequencesAray[1]);
                 break;
             case "EngineeredGene":
            	 Component EngineeredGene = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.EngineeredGene, sequencesAray[1]);
            break;
             case "EngineeredRegion":
            	 Component EngineeredRegion = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.EngineeredRegion, sequencesAray[1]);
            	 break;
             case "FunctionalCompartment":
            	 Component FunctionalCompartment = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.FunctionalCompartment, sequencesAray[1]);
            	 break;
             case "Gene":
            	 Component Gene = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.Gene, sequencesAray[1]);
        
            	 break;
             case "mRNA":
            	 Component mRNA = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.mRNA, sequencesAray[1]);
            	 break;
             
             case "Operator":
            	 Component Operator = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.Operator, sequencesAray[1]);
            	 break;
             case "PhysicalCompartment":
            	 Component PhysicalCompartment = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.PhysicalCompartment, sequencesAray[1]);
            	 break;
             case "Promoter":
            	 Component Promoter = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.Promoter, sequencesAray[1]);
            	 break;
             case "RBS":
            	 Component RBS = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.RBS, sequencesAray[1]);
            	 break;
             case "Terminator":
            	 Component Terminator = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.Terminator, sequencesAray[1]);
            	 break;
             case "TF":
            	 Component TF = SBOLAPI.createDnaComponent(doc, sequencesAray[0], null, theTitleofFile, Role.TF, sequencesAray[1]);
            	 break;
        	 }
     

            
        	
            File outputFile = new File("/Users/joseph/eclipse-workspace/bueno/src/main/webapp/sbolfile.xml"); //THIS WOULD BE BETTER SAVED ON AN EXTERNAL HARDRIVE
            //BUT FOR THE PURUPOSE OF KEEPING EVERYTHING TOGETHER IT IS HERE. ABOVE ONLY WORKS IF THE FOLDERS ARE "REFRESHED"
            
            SBOLIO.write(doc, outputFile, SBOLFormat.RDFXML);
            
         
            
        } catch (SBOLGraphException e) {
            e.printStackTrace();
        }
      
        
        

        
    }

        response.sendRedirect("LastPage.jsp");
     
    }
}
