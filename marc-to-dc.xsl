<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xpath-default-namespace="http://www.loc.gov/MARC21/slim" version="2.0"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="record">
    <rdf:RDF>
      <rdf:Description>
        <xsl:apply-templates select="datafield[@tag='245']"/>
        <xsl:apply-templates select="datafield[@tag = ('100','700','710')]"/>
        <xsl:apply-templates select="datafield[@tag = '260']/subfield[@code=('b','c')]"/>
        <xsl:apply-templates select="datafield[@tag = '300']/subfield[@code=('a','b')]"/>
        <xsl:apply-templates select="datafield[@tag = ('500','501','504','505','518')]"/>
        <xsl:apply-templates select="datafield[@tag = ('650','610','653')]"/>
        <xsl:apply-templates select="datafield[@tag='830']"/>
        <xsl:apply-templates select="leader"/>
        <xsl:apply-templates select="datafield[@tag='041']"/>
        <dc:publisher>Digital Publisher: Galter Health Sciences Library</dc:publisher>
        <dc:format.digitalOrigin>reformatted digital</dc:format.digitalOrigin>
        <dc:format.medium>electronic</dc:format.medium>
      </rdf:Description>
    </rdf:RDF>
  </xsl:template>
  <xsl:template match="datafield[@tag='245']">
    <dc:title>
      <xsl:apply-templates select="subfield[@code = ('a','b')]"/>
    </dc:title>
  </xsl:template>
  <xsl:template match="datafield[@tag='245']/subfield[@code='b']">
    <xsl:text> </xsl:text>
    <xsl:value-of
      select="if (ends-with(.,'/') or ends-with(.,';')) then substring(.,1,string-length(.) - 2) else ."
    />
  </xsl:template>
  <xsl:template match="datafield[@tag = ('100','700','710')]">
    <dc:contributor>
      <xsl:value-of
        select="string-join((subfield[@code='a'],subfield[@code='d'],subfield[@code='e']),' ')"/>
    </dc:contributor>
  </xsl:template>
  <xsl:template match="datafield[@tag = '260']/subfield[@code='b']">
    <dc:publisher>
      <xsl:value-of
        select="if (ends-with(.,'.') or ends-with(.,',')) then substring(.,1,string-length(.) - 1) else ."
      />
    </dc:publisher>
  </xsl:template>
  <xsl:template match="datafield[@tag = '260']/subfield[@code='c']">
    <dc:date.created>
      <xsl:value-of
        select="if (ends-with(.,'.') or ends-with(.,',')) then substring(.,1,string-length(.) - 1) else ."
      />
    </dc:date.created>
  </xsl:template>
  <xsl:template match="datafield[@tag = '300']/subfield[@code='a']">
    <dc:extent>
      <xsl:value-of
        select="if (ends-with(.,';') or ends-with(.,':')) then substring(.,1,string-length(.) - 2) else ."
      />
    </dc:extent>
  </xsl:template>
  <xsl:template match="datafield[@tag='300']/subfield[@code='b']">
    <dc:description>
      <xsl:value-of
        select="if (ends-with(.,';') or ends-with(.,':')) then substring(.,1,string-length(.) - 2) else ."
      />
    </dc:description>
  </xsl:template>
  <xsl:template match="datafield[@tag = ('500','501','504','505','518')]">
    <dc:description>
      <xsl:value-of select="if (ends-with(.,'.')) then substring(.,1,string-length(.) - 1) else ."/>
    </dc:description>
  </xsl:template>
  <xsl:template match="datafield[@tag = ('650','610')]">
    <dc:subject.lcsh>
      <xsl:apply-templates select="subfield[not(@code='2')]"/>
    </dc:subject.lcsh>
  </xsl:template>
  <xsl:template match="datafield[@tag = ('650','610')]/subfield">
    <xsl:value-of select="if (ends-with(.,'.')) then substring(.,1,string-length(.) - 1) else ."/>
    <xsl:if test="following-sibling::subfield[1][not(@code='2')]">
      <xsl:text>; </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="datafield[@tag='653']">
    <dc:subject>
      <xsl:value-of select="string-join(subfield,'; ')"/>
    </dc:subject>
  </xsl:template>
  <xsl:template match="datafield[@tag='830']">
    <dc:relation.ispartofseries>
      <xsl:apply-templates/>
    </dc:relation.ispartofseries>
  </xsl:template>
  <xsl:template match="datafield[@tag='830']/subfield[@code='a']">
    <xsl:value-of select="if (ends-with(.,';')) then substring(.,1,string-length(.) - 1) else ."/>
    <xsl:if test="following-sibling::subfield[@code='a']">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="leader">
    <xsl:variable name="leader6" select="substring(.,7,1)"/>
    <dc:type>
      <xsl:choose>
        <xsl:when test="$leader6=('a','t')">text</xsl:when>
        <xsl:when test="$leader6=('e','f')">cartographic</xsl:when>
        <xsl:when test="$leader6=('c','d')">notated music</xsl:when>
        <xsl:when test="$leader6=('i','j')">sound recording</xsl:when>
        <xsl:when test="$leader6='k'">still image</xsl:when>
        <xsl:when test="$leader6='g'">moving image</xsl:when>
        <xsl:when test="$leader6='r'">three dimensional object</xsl:when>
        <xsl:when test="$leader6='m'">software, multimedia</xsl:when>
        <xsl:when test="$leader6='p'">mixed material</xsl:when>
      </xsl:choose>
    </dc:type>
  </xsl:template>
  <xsl:template match="datafield[@tag='041']">
    <dc:language>
      <xsl:value-of select="subfield[@code='a']"/>
    </dc:language>
  </xsl:template>
</xsl:stylesheet>
