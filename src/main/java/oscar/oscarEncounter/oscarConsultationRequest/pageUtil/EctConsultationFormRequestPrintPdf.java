/**
 * Copyright (c) 2001-2002. Department of Family Medicine, McMaster University. All Rights Reserved. *
 * This software is published under the GPL GNU General Public License.
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version. *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details. * * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *
 *
 *
 * This software was written for the
 * Department of Family Medicine
 * McMaster University
 * Hamilton
 * Ontario, Canada   Creates a new instance of EctConsultationFormRequestPrintAction
 */

/*
 * EctConsultationFormRequestPrintPdf.java
 *
 * Created on November 19, 2007, 4:05 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package oscar.oscarEncounter.oscarConsultationRequest.pageUtil;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oscar.OscarProperties;
import oscar.dms.EDoc;
import oscar.dms.EDocUtil;
import oscar.oscarDB.DBHandler;
import oscar.oscarLab.ca.all.pageUtil.LabPDFCreator;
import oscar.oscarLab.ca.all.parsers.Factory;
import oscar.oscarLab.ca.all.parsers.MessageHandler;
import oscar.util.ConcatPDF;
import oscar.util.UtilDateUtilities;

import org.oscarehr.util.SpringUtils;
import org.oscarehr.util.MiscUtils;
import org.apache.log4j.Logger;

import org.oscarehr.common.dao.ClinicDAO;
import org.oscarehr.common.model.Clinic;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.ColumnText;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;
/**
 *
 * @author wrighd
 */
public class EctConsultationFormRequestPrintPdf {
	private static final Logger logger=MiscUtils.getLogger();
	
    private HttpServletRequest request;
    private HttpServletResponse response;
    
    private PdfReader reader;
    private PdfWriter writer;
    private ColumnText ct;
    private Document document;
    private PdfContentByte cb;
    private BaseFont bf;
    private float height;
    private float width;
    
    private int PAGENUM = 1;
    private final float LINEHEIGHT = 14;
    private final float FONTSIZE = 10;
    
    /** Creates a new instance of EctConsultationFormRequestPrintPdf */
    public EctConsultationFormRequestPrintPdf(HttpServletRequest request,HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    public void printPdf() throws IOException, DocumentException{
        
        EctConsultationFormRequestUtil reqForm = new EctConsultationFormRequestUtil();
        reqForm.estRequestFromId((String) request.getAttribute("reqId"));
        
        //make sure we have data to print
        if( reqForm == null )
            throw new DocumentException();
        
        // init req form info
        reqForm.specAddr = request.getParameter("address");
        if (reqForm.specAddr == null){reqForm.specAddr = new String(); }
        reqForm.specPhone = request.getParameter("phone");
        if (reqForm.specPhone == null){ reqForm.specPhone = ""; }
        reqForm.specFax = request.getParameter("fax");
        if (reqForm.specFax == null){ reqForm.specFax = ""; }
        
        //Create new file to save form to
        String path = OscarProperties.getInstance().getProperty("DOCUMENT_DIR");
        String fileName = path + "ConsultationRequestForm-"+UtilDateUtilities.getToday("yyyy-MM-dd.hh.mm.ss")+".pdf";
        FileOutputStream out = new FileOutputStream(fileName);
        
        //Create the document we are going to write to
        document = new Document();
        writer = PdfWriter.getInstance(document,out);
        
        //Use the template located at '/oscar/oscarEncounter/oscarConsultationRequest/props'
        reader = new PdfReader("/oscar/oscarEncounter/oscarConsultationRequest/props/consultationFormRequest.pdf");
        Rectangle pSize = reader.getPageSize(1);
        width = pSize.getWidth();
        height = pSize.getHeight();
        document.setPageSize(pSize);
        
        document.addTitle("Consultation Form Request");
        document.addCreator("OSCAR");
        document.open();
        
        //Create the font we are going to print to
        bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        
        cb = writer.getDirectContent();
        ct = new ColumnText(cb);
        cb.setColorStroke(new Color(0,0,0));
        
        // start writing the pdf document
        PdfImportedPage page1 = writer.getImportedPage(reader, 1);
        cb.addTemplate(page1, 1, 0, 0, 1, 0, 0);
        addFooter();
        setAppointmentInfo(reqForm);
        
        // add the dynamically positioned text elements
        float dynamicHeight = 0;
        dynamicHeight = addDynamicPositionedText("Reason For Consultation: ", reqForm.reasonForConsultation, dynamicHeight, reqForm);
        dynamicHeight = addDynamicPositionedText("Pertinent Clinical Information: ", reqForm.clinicalInformation, dynamicHeight, reqForm);
        dynamicHeight = addDynamicPositionedText("Significant Concurrent Problems: ", reqForm.concurrentProblems, dynamicHeight, reqForm);
        dynamicHeight = addDynamicPositionedText("Current Medications: ", reqForm.currentMedications, dynamicHeight, reqForm);
        dynamicHeight = addDynamicPositionedText("Allergies: ", reqForm.allergies, dynamicHeight, reqForm);
        
        document.close();
        reader.close();
        writer.close();
        out.close();
        
        // combine the recently created pdf with any pdfs that were added to the consultation request form
        combinePDFs(fileName);
        
    }
    
    
    
    private float addDynamicPositionedText(String name, String text, float dynamicHeight, EctConsultationFormRequestUtil reqForm) throws DocumentException, IOException{
        if (text != null && text.length() > 0){
            Font boldFont = new Font(bf, FONTSIZE, Font.BOLD);
            Font font = new Font(bf, FONTSIZE, Font.NORMAL);
            float lineCount = (name.length() + text.length()) / 100;
            
            // if there is not enough room on the page for the text start on the next page
            if ( (height - 264 - dynamicHeight - lineCount*LINEHEIGHT) < LINEHEIGHT*3 ){
                nextPage(reqForm);
                dynamicHeight = LINEHEIGHT - 152;
            }
            
            ct.setSimpleColumn(new Float(85), height - 264 - dynamicHeight - lineCount*LINEHEIGHT, new Float(526), height - 250 - dynamicHeight, LINEHEIGHT, Element.ALIGN_LEFT);
            ct.addText(new Phrase(name, boldFont));
            ct.addText(new Phrase(text, font));
            ct.go();
            dynamicHeight += lineCount*LINEHEIGHT + LINEHEIGHT*2;
        }
        
        return dynamicHeight;
    }
    
    private void setAppointmentInfo(EctConsultationFormRequestUtil reqForm) throws DocumentException{
        
        printClinicData();
        Font font = new Font(bf, FONTSIZE, Font.NORMAL);
        
        // Set consultant info
        cb.beginText();
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.referalDate, 190, height - 112, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.urgency.equals("1") ? "Urgent" : (reqForm.urgency.equals("2") ? "Non-Urgent" : "Return"), 190, height - 125, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.getServiceName(reqForm.service), 190, height - 139, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.getSpecailistsName(reqForm.specialist), 190, height - 153, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.specPhone, 190, height - 166, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.specFax, 190, height - 181, 0);
        cb.endText();
        ct.setSimpleColumn(new Float(190), height - 223, new Float(290), height - 181, LINEHEIGHT, Element.ALIGN_LEFT);
        ct.addText(new Phrase(reqForm.specAddr.replaceAll("<br>", "\n"), font));
        ct.go();
        
        // Set patient info
        cb.beginText();
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.patientName, 385, height - 112, 0);
        cb.endText();
        ct.setSimpleColumn(new Float(385), height - 153, new Float(585), height - 112, LINEHEIGHT, Element.ALIGN_LEFT);
        ct.addText(new Phrase(reqForm.patientAddress.replaceAll("<br>", " "), font));
        ct.go();
        
        cb.beginText();
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.patientPhone, 385, height - 166, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.patientDOB, 385, height - 181, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, (reqForm.patientHealthCardType+" "+reqForm.patientHealthNum+" "+reqForm.patientHealthCardVersionCode).trim(), 440, height - 195, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.appointmentHour+":"+reqForm.appointmentMinute+" "+reqForm.appointmentPm+" " +
                reqForm.appointmentDay+"/"+reqForm.appointmentMonth+"/"+reqForm.appointmentYear, 440, height - 208, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.patientChartNo, 385, height - 222, 0);
        cb.endText();
    }
    
    private void nextPage(EctConsultationFormRequestUtil reqForm) throws DocumentException, IOException{
        PdfImportedPage page2 = writer.getImportedPage(reader, 2);
        document.newPage();
        cb.addTemplate(page2, 1, 0, 0, 1, 0, 0);
        
        printClinicData();
        cb.beginText();
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, reqForm.patientName, 110, height - 82, 0);
        cb.endText();
        
        PAGENUM++;
        addFooter();
        
    }
    
    private void printClinicData(){
		ClinicDAO clinicDao = (ClinicDAO)SpringUtils.getBean("clinicDAO");
		
		String clinicNo = this.request.getParameter("clinicNo");
		Clinic clinic = null;
		
		try {
			int clinicNoAsInt = Integer.parseInt(clinicNo);
			clinic = clinicDao.find(clinicNoAsInt);
		} catch (Exception e) {
			logger.error("Unable to parse clinic number.", e);
		}
		
		// Error check
		if (clinic == null)
			clinic = clinicDao.getClinic();
		if (clinic == null) {
			logger.error("No clinic found in OSCAR!");
			return;
		}
		
		
        cb.beginText();
        
        cb.setFontAndSize(bf, 16);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, clinic.getClinicName(), 90, height - 70, 0);
        
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_RIGHT, clinic.getClinicAddress()+", "+clinic.getClinicCity()+", "+clinic.getClinicProvince()+", "+clinic.getClinicPostal(), 533, height - 70, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, clinic.getClinicPhone(), 360, height - 82, 0);
        cb.showTextAligned(PdfContentByte.ALIGN_LEFT, clinic.getClinicFax(), 471, height - 82, 0);
        
        cb.endText();
    }
    
    private void addFooter() throws DocumentException, IOException{
        cb.beginText();
        cb.setFontAndSize(bf, FONTSIZE);
        cb.showTextAligned(PdfContentByte.ALIGN_CENTER, "-"+PAGENUM+"-", width/2, 30, 0);
        cb.endText();
        
        
        // add promotext if it is enabled
        if ( OscarProperties.getInstance().getProperty("FORMS_PROMOTEXT") != null){
            cb.beginText();
            cb.setFontAndSize(BaseFont.createFont(BaseFont.HELVETICA,BaseFont.CP1252,BaseFont.NOT_EMBEDDED), 6);
            cb.showTextAligned(PdfContentByte.ALIGN_CENTER, OscarProperties.getInstance().getProperty("FORMS_PROMOTEXT"), width/2, 19, 0);
            cb.endText();
        }
    }
    
    private void combinePDFs(String currentFileName) throws IOException{
        
        String demoNo = (String) request.getAttribute("demo");
        String reqId = (String) request.getAttribute("reqId");
        ArrayList consultdocs = EDocUtil.listDocs(demoNo, reqId, EDocUtil.ATTACHED);
        ArrayList pdfDocs = new ArrayList();

        // add recently created pdf to the list
        pdfDocs.add(currentFileName);
        
        for (int i=0; i < consultdocs.size(); i++){
            EDoc curDoc = (EDoc) consultdocs.get(i);
            if ( curDoc.isPDF() )
                pdfDocs.add(curDoc.getFilePath());
        }
        //TODO:need to do something about the docs that are not PDFs
        
        // create pdfs from attached labs
        try {
            
            String sql = "SELECT lab_no FROM patientLabRouting p, consultdocs c WHERE p.id = c.document_no AND c.requestId='"+reqId+"' AND c.doctype='L' AND c.deleted IS NULL";
            
            ResultSet rs = DBHandler.GetSQL(sql);
            while(rs.next()){
                String segmentId = oscar.Misc.getString(rs, "lab_no");
                request.setAttribute("segmentID", segmentId);
                MessageHandler handler = Factory.getHandler(segmentId);
                String fileName = OscarProperties.getInstance().getProperty("DOCUMENT_DIR")+"//"+handler.getPatientName().replaceAll("\\s", "_")+"_"+handler.getMsgDate()+"_LabReport.pdf";
                OutputStream os = new FileOutputStream(fileName);
                LabPDFCreator pdf = new LabPDFCreator(request, os);
                pdf.printPdf();
                pdfDocs.add(fileName);
            }
            rs.close();

        }catch(DocumentException de) {
            request.setAttribute("printError", new Boolean(true));
        }catch(IOException ioe) {
            request.setAttribute("printError", new Boolean(true));
        }catch(Exception e){
            request.setAttribute("printError", new Boolean(true));
        }
        
        response.setContentType("application/pdf");  //octet-stream
        response.setHeader("Content-Disposition", "attachment; filename=\"ConsultationFormRequest.pdf\"");
        ConcatPDF.concat(pdfDocs,response.getOutputStream());
        
    }
}
