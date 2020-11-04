<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.loc.gov/mods/v3"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://functions/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:zs="http://www.loc.gov/zing/srw/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:saxon="http://saxon.sf.net/"
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd"
    exclude-result-prefixes="xs xd saxon zs xsi f #default" version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:output name="originalFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml"
        version="1.0"/>
    <xsl:output name="archiveFile" method="xml" indent="yes" encoding="UTF-8" version="1.0"
        media-type="text/xml"/>

    <xsl:include href="commons/params.xsl"/>
    <xsl:include href="commons/functions.xsl"/>
    <xsl:include href="commons/countryList.xsl"/>


    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b>ar 12, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> Carlos.Martinez</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>


    <!-- <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>-->

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <!-- <xsl:template match="zs:name">
        <xsl:element name="{local-name()}">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>-->
    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <!--   <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>-->



    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="/">
        <zs:searchRetrieveResponse>
            <modsCollection>
                <xsl:for-each select="*//mods" xpath-default-namespace="http://www.loc.gov/mods/v3">
                    <!--//*[namespace-uri() = 'http://www.loc.gov/mods/v3' and local-name() = 'mods']">-->
                    <zs:records xmlns:zs="http://www.loc.gov/zing/srw/">
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
                            <xsl:namespace name="xsi"
                                select="'http://www.w3.org/2001/XMLSchema-instance'"/>
                            <xsl:attribute name="xsi:schemaLocation"
                                select="normalize-space('http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-7.xsd')"/>
                            <xsl:attribute name="version" select="'3.7'"/>
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
                            <xsl:call-template name="extension"/>
                        </mods>
                    </xsl:result-document>
                </xsl:for-each>
            </modsCollection>
        </zs:searchRetrieveResponse>
    </xsl:template>

    <!--titleInfo-->
    <xd:doc>
        <xd:desc>
            <xd:a docid="titleInfo_id"> titleInfo</xd:a>
        </xd:desc>
        <xd:param name="titles"/>
    </xd:doc>
    <xsl:template match="mods:titleInfo" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <!--match="*[namespace-uri() = 'http://www.loc.gov/mods/v3' and local-name() = 'titleInfo']"
        xpath-default-namespace="http://www.loc.gov/mods/v3">-->
        <xsl:param name="titles" as="xs:string*"/>
        <titleInfo>
            <xsl:if test="@type">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>
            <xsl:if test="nonSort">
                <nonSort xml:space="preserve">
                        <xsl:value-of select="nonSort"/>
               </nonSort>
            </xsl:if>
            <title>
                <xsl:value-of select="normalize-space(title)"/>
            </title>
            <xsl:if test="subTitle">
                <subTitle>
                    <xsl:value-of select="subTitle"/>
                </subTitle>
            </xsl:if>
            <!--partNumber-->
            <xsl:choose>
                <xsl:when test="partNumber">
                    <partNumber>
                        <xsl:value-of select="partNumber"/>
                    </partNumber>
                    <partName>
                        <xsl:value-of select="partName"/>
                    </partName>
                </xsl:when>
                <xsl:when test="partName">
                    <partName>
                        <xsl:value-of select="partName"/>
                    </partName>
                </xsl:when>
            </xsl:choose>
        </titleInfo>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:name" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <name>
            <xsl:attribute name="type" select="@type"/>
            <xsl:for-each select="namePart">
                <namePart>
                    <xsl:if test="@type">
                        <xsl:attribute name="type" select="@type"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </namePart>
            </xsl:for-each>
        </name>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:typeOfResource" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <typeOfResource>
            <xsl:value-of select="."/>
        </typeOfResource>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:genre" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <genre>
            <xsl:attribute name="authority" select="@authority"/>
            <xsl:value-of select="."/>
        </genre>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:originInfo" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <originInfo>
            <xsl:if test="@displayLabel">
                <xsl:attribute name="displayLabel" select="@displayLabel"/>
            </xsl:if>
            <xsl:if test="@altRepGroup">
                <xsl:attribute name="altRepGroup" select="@altRepGroup"/>
            </xsl:if>
            <xsl:if test="@eventType">
                <xsl:attribute name="eventType" select="@eventType"/>
            </xsl:if>
            <xsl:for-each select="place">
                <place>
                    <placeTerm>
                        <xsl:if test="placeTerm/@type">
                            <xsl:attribute name="type" select="placeTerm/@type"/>
                        </xsl:if>
                        <xsl:if test="placeTerm/@authority">
                            <xsl:attribute name="authority" select="placeTerm/@authority"/>
                        </xsl:if>
                        <xsl:value-of select="."/>
                    </placeTerm>
                </place>
            </xsl:for-each>
            <xsl:for-each select="publisher">
                <publisher>
                    <xsl:value-of select="."/>
                </publisher>
            </xsl:for-each>
            <xsl:for-each select="dateIssued">
                <dateIssued>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateIssued>
            </xsl:for-each>
            <xsl:for-each select="dateCreated">
                <dateCreated>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateCreated>
            </xsl:for-each>
            <xsl:for-each select="dateCaptured">
                <dateCaptured>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateCaptured>
            </xsl:for-each>
            <xsl:for-each select="dateValid">
                <dateValid>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateValid>
            </xsl:for-each>
            <xsl:for-each select="dateModified">
                <dateModified>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateModified>
            </xsl:for-each>
            <xsl:for-each select="copyrightDate">
                <copyrightDate>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </copyrightDate>
            </xsl:for-each>
            <xsl:for-each select="dateOther">
                <dateOther>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                        <xsl:value-of select="."/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </dateOther>
            </xsl:for-each>
            <xsl:for-each select="edition">
                <edition>
                    <xsl:if test="@encoding">
                        <xsl:attribute name="encoding" select="@encoding"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </edition>
            </xsl:for-each>
            <xsl:if test="issuance">
                <issuance>
                    <xsl:value-of select="issuance"/>
                </issuance>
            </xsl:if>
            <xsl:for-each select="frequency">
                <frequency>
                    <xsl:if test="@authority">
                        <xsl:attribute name="authority" select="@authority"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </frequency>
            </xsl:for-each>
        </originInfo>
    </xsl:template>

    <xd:doc>
        <xd:desc>MODS language tag</xd:desc>
    </xd:doc>
    <xsl:template match="mods:language" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <language>
            <languageTerm>
                <xsl:if test="languageTerm/@authority">
                    <xsl:attribute name="authority" select="languageTerm/@authority"/>
                </xsl:if>
                <xsl:if test="languageTerm/@type">
                    <xsl:attribute name="type" select="languageTerm/@type"/>
                </xsl:if>
                <xsl:value-of select="."/>
            </languageTerm>
        </language>
    </xsl:template>


    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:physicalDescription"
        xpath-default-namespace="http://www.loc.gov/mods/v3">
        <physicalDescription>
            <xsl:for-each select="form">
                <!--form-->
                <form>
                    <!--@type-->
                    <xsl:if test="@type">
                        <xsl:attribute name="type" select="@type"/>
                    </xsl:if>
                    <!--@authority-->
                    <xsl:if test="@authority">
                        <xsl:attribute name="authority" select="@authority"/>
                    </xsl:if>
                    <xsl:value-of select="."/>
                </form>
            </xsl:for-each>
            <!--reformattingQuality-->
            <xsl:if test="reformattingQuality">
                <reformattingQuality>
                    <xsl:value-of select="reformattingQuality"/>
                </reformattingQuality>
            </xsl:if>
            <!--internetMediaType-->
            <xsl:if test="internetMediaType">
                <internetMediaType>
                    <xsl:value-of select="internetMediaType"/>
                </internetMediaType>
            </xsl:if>
            <!--extent-->
            <xsl:if test="extent">
                <extent>
                    <xsl:value-of select="extent"/>
                </extent>
            </xsl:if>
            <!--digitalOrigin-->
            <xsl:if test="digitalOrigin">
                <digitalOrigin>
                    <xsl:value-of select="digitalOrigin"/>
                </digitalOrigin>
            </xsl:if>
            <!--note-->
            <xsl:if test="note">
                <!--@type-->
                <xsl:if test="note/@type">
                    <xsl:attribute name="type" select="form/@type"/>
                </xsl:if>
                <note>
                    <xsl:value-of select="note"/>
                </note>
            </xsl:if>
        </physicalDescription>

    </xsl:template>


    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:note" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <note>
            <!-- <xsl:if test="@type or @altRepGroup">
                <xsl:attribute name="{{@id}}">
                    <xsl:sequence select="@type | @altRepGroup"/>
                </xsl:attribute>
            </xsl:if>-->
            <xsl:if test="@type">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>
            <xsl:if test="@altRepGroup">
                <xsl:attribute name="altRepGroup" select="@altRepGroup"/>
            </xsl:if>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>

    <xd:doc>
        <xd:desc/>

    </xd:doc>
    <xsl:template match="mods:subject" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <subject>
            <xsl:if test="normalize-space(.) != ''">
                <xsl:if test="geographicCode">
                    <geographicCode>
                        <xsl:attribute name="authority" select="geographicCode/@authority"/>
                        <xsl:value-of select="geographicCode"/>
                    </geographicCode>
                </xsl:if>
                <xsl:if test="topic or geographic">
                    <xsl:attribute name="authority" select="@authority"/>
                    <xsl:sequence select="topic[position()] | geographic"/>
                </xsl:if>
            </xsl:if>
        </subject>
    </xsl:template>

    <xd:doc>
        <xd:desc/> + </xd:doc>
    <xsl:template match="mods:classification" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <classification>
            <xsl:if test="@authority">
                <xsl:attribute name="authority" select="@authority"/>
            </xsl:if>
            <xsl:if test="@authorityURI">
                <xsl:attribute name="authorityURI" select="@authorityURI"/>
            </xsl:if>
            <xsl:if test="@valueURI">
                <xsl:attribute name="valueURI" select="@valueURI"/>
            </xsl:if>
            <xsl:if test="@altRepGroup">
                <xsl:attribute name="altRepGroup" select="@altRepGroup"/>
            </xsl:if>
            <xsl:if test="@displayLabel">
                <xsl:attribute name="displayLabel" select="@displayLabel"/>
            </xsl:if>
            <xsl:if test="@usage">
                <xsl:attribute name="usage" select="@usage"/>
            </xsl:if>
            <xsl:if test="@edition">
                <xsl:attribute name="edition" select="@edition"/>
            </xsl:if>
            <xsl:if test="@generator">
                <xsl:attribute name="generator" select="@generator"/>
            </xsl:if>
            <xsl:value-of select="."/>
        </classification>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:relatedItem" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <relatedItem>
            <xsl:attribute name="type" select="@type"/>
            <xsl:apply-templates select="titleInfo"/>
            <xsl:apply-templates select="identifier"/>
        </relatedItem>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:identifier" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <identifier>
            <xsl:attribute name="type" select="@type"/>
            <xsl:value-of select="."/>
        </identifier>
    </xsl:template>

    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="mods:location" xpath-default-namespace="http://www.loc.gov/mods/v3">
        <location>
            <url>
                <xsl:attribute name="displayLabel" select="url/@displayLabel"/>
                <xsl:attribute name="usage" select="url/@usage"/>
                <xsl:value-of select="."/>
            </url>
        </location>
    </xsl:template>

    <xd:doc>
        <xd:desc>
            <!--Language-related: lang; xml:lang; script; transliteration
                Internal Linking: altRepGroup
                External Linking: xlink:href
                Miscellaneous: displayLabel; altFormat; contentType; shareable
                Specific: type-->
        </xd:desc>
    </xd:doc>
    <xsl:template match="mods:abstract" xpath-default-namespace="http://www.loc.gov/mods.v3">
        <abstract>
            <xsl:choose>
                <xsl:when test="@type">
                    <xsl:attribute name="type" select="@type"/>
                </xsl:when>
                <xsl:when test="@displayLabel">
                    <xsl:attribute name="displayLabel" select="@displayLabel"/>
                </xsl:when>
                <xsl:when test="@altFormart">
                    <xsl:attribute name="altFormat" select="@altFormat"/>
                </xsl:when>
                <xsl:when test="@contentType">
                    <xsl:attribute name="contentType" select="@contentType"/>
                </xsl:when>
                <xsl:when test="@shareable">
                    <xsl:attribute name="shareable" select="@shareable"/>
                </xsl:when>
                <!--  <xsl:attribute name="{{xlink:href}}" select="@href"/>-->
            </xsl:choose>


            <xsl:value-of select="."/>

        </abstract>


    </xsl:template>


    <xd:doc>
        <xd:desc>
            <xd:p/>
        </xd:desc>
        <xd:param>
            <xd:p/>
        </xd:param>
        <xd:return>
            <xd:p/>
        </xd:return>
    </xd:doc>
    <xsl:template match="mods:recordInfo" xpath-default-namespace="http://www.loc.gov/mods.v3">
        <recordInfo>
            <descriptionStandard>
                <xsl:value-of select="mods:descriptionStandard"/>
            </descriptionStandard>
            <recordContentSource>
                <xsl:if test="mods:recordContentSource/@authority">
                    <xsl:attribute name="authority" select="mods:recordContentSource/@authority"/>
                </xsl:if>
                <xsl:value-of select="mods:recordContentSource"/>
            </recordContentSource>
            <recordCreationDate>
                <xsl:if test="mods:recordCreationDate/@encoding">
                    <xsl:attribute name="encoding" select="mods:recordCreationDate/@encoding"/>
                </xsl:if>
                <xsl:value-of select="mods:recordCreationDate"/>
            </recordCreationDate>
            <recordChangeDate>
                <xsl:if test="mods:recordCreationDate/@encoding">
                    <xsl:attribute name="encoding" select="mods:recordCreationDate/@encoding"/>
                </xsl:if>
                <xsl:value-of select="mods:recordChangeDate"/>
            </recordChangeDate>
            <recordIdentifier>
                <xsl:value-of select="mods:recordIdentifier"/>
            </recordIdentifier>
            <recordOrigin>
                <xsl:value-of select="mods:recordOrigin"/>
            </recordOrigin>
        </recordInfo>
    </xsl:template>
    <xd:doc name="extension" scope="component">
        <xd:desc>
            <xd:p><xd:b>vendorName:</xd:b> Name of the vendor supplying the metadata.</xd:p>
            <xd:p><xd:b>archiveFile:</xd:b> file (xml or zip) that originally heldsource
                data.</xd:p>
            <xd:p><xd:b>originalFilename:</xd:b> Name of the file currently being processed.</xd:p>
            <xd:p><xd:b>workingDir:</xd:b> Name of the directory containing the file currently being
                processed.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template name="extension">
        <xsl:comment>NAL extension template</xsl:comment>
        <extension>
            <vendorName>
                <xsl:value-of select="$vendorName"/>
            </vendorName>
            <archiveFile>
                <xsl:value-of select="$archiveFile"/>
            </archiveFile>
            <originalFile>
                <xsl:value-of select="$originalFilename"/>
            </originalFile>
            <workingDirectory>
                <xsl:value-of select="$workingDir"/>
            </workingDirectory>
            <filePath>
                <xsl:value-of select="$filePath"/>
            </filePath>
        </extension>
    </xsl:template>
</xsl:stylesheet>
