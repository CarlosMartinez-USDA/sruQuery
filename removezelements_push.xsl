<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.loc.gov/mods/v3"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://functions/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:zs="http://www.loc.gov/zing/srw/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd"
    exclude-result-prefixes="#all" version="2.0">
    
   
    <xsl:strip-space elements="*"/>
    
    <xsl:output name="originalFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/>   
    <xsl:output name="archiveFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/> 
    
    
    <xsl:include href="commons/common.xsl"/>
    <xsl:include href="commons/params.xsl"/>
  
  
  <!-- Uses XSLT "push" programming to accomplish a similar goal without as much effort. The caveat is there is no room for customization.
      -->

    
    
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b>ar 12, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> Carlos.Martinez</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>
    
    <xd:doc>
        <xd:desc>mods default template</xd:desc>
    </xd:doc>
    <xsl:template match="mods" xpath-default-namespace="http://www.loc.gov/mods/v3"/>
      
    <xd:doc>
        <xd:desc>sru template </xd:desc>
    </xd:doc>
    <xsl:template match="zs:name" xpath-default-namespace="http://www.loc.gov/zing/srw/"/>
         
    <xd:doc>
        <xd:desc>root template</xd:desc>      
    </xd:doc>
    <xsl:template match="/">  
        <zs:searchRetrieveResponse xmlns:zs="http://www.loc.gov/zing/srw/">
            <modsCollection>
                <xsl:for-each select="*//mods" xpath-default-namespace="http://www.loc.gov/mods/v3">                   
                    <zs:records>
                        <xsl:result-document encoding="UTF-8" indent="yes" method="xml"
                            media-type="text/xml" format="archiveFile"
                            href="{$workingDir}A-{$originalFilename}_{position()}.xml">
                            <xsl:copy-of select="."/>
                            <!--MODS-->
                        </xsl:result-document>
                    </zs:records>
                    <xsl:result-document encoding="UTF-8" indent="yes" method="xml"
                        media-type="text/xml" format="originalFile"
                        href="{$workingDir}N-{$originalFilename}_{position()}.xml">
                        <mods>
                            <xsl:namespace name="zs" select="'http://www.loc.gov/zing/srw/'"/>
                            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
                            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>                                                       
                            <xsl:attribute name="version" select="@version"/>
                            <xsl:attribute name="xsi:schemaLocation" select="@xsi:schemaLocation"/>
                            <xsl:apply-templates select="mods:titleInfo"/>
                            <xsl:apply-templates select="mods:name"/>
                            <xsl:apply-templates select="mods:typeOfResource"/>
                            <xsl:apply-templates select="mods:genre"/>
                            <xsl:apply-templates select="mods:originInfo"/>
                            <xsl:apply-templates select="mods:language"/>
                            <xsl:apply-templates select="mods:physicalDescription"/>
                            <xsl:apply-templates select="mods:abstract"/>
                            <xsl:apply-templates select="mods:tableOfContents"/>
                            <xsl:apply-templates select="mods:targetAudience"/>
                            <xsl:apply-templates select="mods:note"/>
                            <xsl:apply-templates select="mods:subject"/>
                            <xsl:apply-templates select="mods:classification"/>
                            <xsl:apply-templates select="mods:relatedItem"/>
                            <xsl:apply-templates select="mods:identifier"/>
                            <xsl:apply-templates select="mods:location"/>
                            <xsl:apply-templates select="mods:accessCondition"/>
                            <xsl:apply-templates select="mods:part"/>
                            <xsl:apply-templates select="mods:extension"/>
                            <xsl:apply-templates select="mods:recordInfo"/>                            
                        </mods>
                    </xsl:result-document>
                </xsl:for-each>
            </modsCollection>
        </zs:searchRetrieveResponse>
    </xsl:template>
</xsl:stylesheet>
    