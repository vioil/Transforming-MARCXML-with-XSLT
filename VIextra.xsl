<xsl:stylesheet xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" exclude-result-prefixes="marc">
    <xsl:import href="MARC21slimUtils.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="marc:record">
        <xsl:variable name="leader" select="marc:leader"/>
        <xsl:variable name="leader6" select="substring($leader,7,1)"/>
        <xsl:variable name="leader7" select="substring($leader,8,1)"/>
        <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
        <rdf:Description>
            <xsl:for-each select="marc:datafield[@tag=245]">
                <xsl:variable name="title">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abcfghk</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:title><xsl:value-of select="substring($title,1,string-length($title)-1)"/></dc:title>
            </xsl:for-each>
            
            <xsl:for-each
                select="marc:datafield[@tag=246]">
                <dc:title.alternative>
                    <xsl:value-of select="."/>
                </dc:title.alternative>
            </xsl:for-each>
            
            <xsl:for-each select="marc:datafield[@tag=100]|marc:datafield[@tag=700]">
                <xsl:variable name="creator">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">adq</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:creator><xsl:value-of select="substring($creator,1,string-length($creator)-1)"/>
                </dc:creator>
            </xsl:for-each>
            
            <xsl:for-each select="marc:datafield[@tag=710]">
                <xsl:variable name="contributor">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abdq</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:contributor><xsl:value-of select="substring($contributor,1,string-length($contributor)-1)"/>
                </dc:contributor>
            </xsl:for-each>
           
            <dc:type>
                <xsl:if test="$leader7='c'">
                    <xsl:text>collection</xsl:text>
                </xsl:if>
                <xsl:if test="$leader6='d' or $leader6='f' or $leader6='p' or $leader6='t'">
                    <xsl:text>text</xsl:text>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="$leader6='a' or $leader6='t'">text</xsl:when>
                    <xsl:when test="$leader6='e' or $leader6='f'">cartographic</xsl:when>
                    <xsl:when test="$leader6='c' or $leader6='d'">notated music</xsl:when>
                    <xsl:when test="$leader6='i' or $leader6='j'">sound recording</xsl:when>
                    <xsl:when test="$leader6='k'">still image</xsl:when>
                    <xsl:when test="$leader6='g'">moving image</xsl:when>
                    <xsl:when test="$leader6='r'">three dimensional object</xsl:when>
                    <xsl:when test="$leader6='m'">software, multimedia</xsl:when>
                    <xsl:when test="$leader6='p'">mixed material</xsl:when>
                </xsl:choose>     
            </dc:type>
            <xsl:for-each select="marc:datafield[@tag=655]/normalize-space()">
                <dc:type>
                    <xsl:value-of select="."/>
                </dc:type>
            </xsl:for-each>
            
            <xsl:for-each select="marc:datafield[@tag=260]">
                <xsl:variable name="publisher">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">b</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:publisher><xsl:value-of select="substring($publisher,1,string-length($publisher))"/></dc:publisher>
            </xsl:for-each>
            
            <xsl:for-each select="marc:datafield[@tag=260]">
                <xsl:variable name="date.created">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">c</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:date.created><xsl:value-of select="substring($date.created,1,string-length($date.created)-1)"/></dc:date.created>
            </xsl:for-each>
            
            <xsl:for-each select="marc:datafield[@tag=300]">
                <dc.description>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abc</xsl:with-param>
                    </xsl:call-template>
                </dc.description>
            </xsl:for-each>

            <xsl:for-each select="marc:datafield[@tag=500]">
                <dc.description>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </dc.description>
            </xsl:for-each>

            <xsl:for-each select="marc:datafield[@tag=504]">
                <xsl:variable name="description"> 
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:description><xsl:value-of select="substring($description,1,string-length($description)-1)"/></dc:description>  
            </xsl:for-each>
 
            <xsl:for-each select="marc:datafield[@tag=546]">
                <dc:language.iso>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </dc:language.iso>
            </xsl:for-each>

            <xsl:for-each select="marc:datafield[@tag=590]">
                <dc:type.material>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </dc:type.material>
            </xsl:for-each>
       
            <xsl:for-each select="marc:datafield[@tag=595]">
                <dc:format.digitalOrigin>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </dc:format.digitalOrigin>
            </xsl:for-each>
           
            <xsl:for-each select="marc:datafield[@tag=596]">
                <dc:format.medium>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">a</xsl:with-param>
                    </xsl:call-template>
                </dc:format.medium>
            </xsl:for-each>

            <xsl:for-each select="marc:datafield[@tag=600]">
                <xsl:variable name="subject.lcsh"> 
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abcdefghjklmnopqrstuvxyz0234</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:subject.lcsh><xsl:value-of select="substring($subject.lcsh,1,string-length($subject.lcsh)-1)"/></dc:subject.lcsh>
             </xsl:for-each>

            <xsl:for-each select="marc:datafield[@tag=650]">
                <xsl:variable name="subject.lcsh"> 
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abcdevxy034</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:subject.lcsh><xsl:value-of select="substring($subject.lcsh,1,string-length($subject.lcsh)-1)"/></dc:subject.lcsh>
            </xsl:for-each>
   
            <xsl:for-each select="marc:datafield[@tag=830]">
                <xsl:variable name="relation.isPartOfSeries"> 
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abcdevxyz034</xsl:with-param>
                    </xsl:call-template>
                </xsl:variable>
                <dc:relation.isPartOfSeries><xsl:value-of select="substring($relation.isPartOfSeries,1,string-length($relation.isPartOfSeries)-1)"/></dc:relation.isPartOfSeries>
            </xsl:for-each>
            
            <dc:language.iso>en_US</dc:language.iso>
            <dc:type.material>video</dc:type.material>
            <dc:format.digitalOrigin>reformatted digital</dc:format.digitalOrigin>
            <dc:format.medium>electronic</dc:format.medium>

        </rdf:Description>
    </xsl:template>
</xsl:stylesheet>
