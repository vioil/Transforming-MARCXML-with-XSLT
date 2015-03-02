<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.loc.gov/MARC21/slim" exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="record">
        <xsl:value-of select="controlfield[@tag='001']/normalize-space()"/>
        <xsl:text>&#x09;</xsl:text>
        <xsl:value-of select="datafield[@tag='035']/normalize-space()"/>
        <xsl:text>&#x09;</xsl:text>
        <xsl:value-of select="datafield[@tag='830']/subfield[@code='v']/normalize-space()"/>
        <xsl:text>&#x09;</xsl:text>
    </xsl:template>
</xsl:stylesheet>