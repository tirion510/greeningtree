package com.greeningtree.bean.common;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.annotation.XmlTransient;

@XmlTransient
public class JObject {
	public String objectToXml()
	{
		try {  
            JAXBContext context = JAXBContext.newInstance(this.getClass());
            Marshaller marshaller = context.createMarshaller();
            StringWriter writer = new StringWriter();
            marshaller.marshal(this, writer);
            if(writer != null)
            {
            	writer.close();
            	return writer.toString();
            }
            
        } catch (JAXBException e) {  
            e.printStackTrace();  
        } catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public Object xmlToObject(String xml)
	{
		Object object = new Object(); 
        try {  
            JAXBContext jaxbContext = JAXBContext.newInstance(this.getClass());  
            Unmarshaller um = jaxbContext.createUnmarshaller();  
            object = (Object)um.unmarshal(new ByteArrayInputStream(xml.getBytes()));  
        } catch (JAXBException e) {
        	e.printStackTrace();
        	return this.getClass();
        	
        }  
        return object;
	}
}
