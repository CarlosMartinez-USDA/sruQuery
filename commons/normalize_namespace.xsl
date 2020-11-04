<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" omit-xml-declaration="yes" encoding="utf-8"/>

    <!-- For each element, create a new element with the same local-name (no namespace) -->
    <xsl:template match="*">
        <xsl:element name="{local-name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Skip the root element, just process its children. -->
    <xsl:template match="/*">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
