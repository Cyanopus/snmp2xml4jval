<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:functx="http://www.functx.com"
                xmlns:snmpwalk="net.itransformers.snmptoolkit.Walk"
        >
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        HEADER: v7<xsl:for-each select="/root/objects/object">
        OBJECT:
            object: <xsl:value-of select="@name"/>
            os:
            index: .<xsl:value-of select="indexes/index/oid/@value"/>
            octets: <xsl:for-each select="indexes/index/syntax/@syntax">
        <xsl:variable name="syntax" select="."/>
        <xsl:choose>
            <xsl:when test="$syntax='INTEGER'">i</xsl:when>
            <xsl:when test="$syntax='OCTET STRING'">s</xsl:when>
            <xsl:otherwise>S</xsl:otherwise>
        </xsl:choose>

    </xsl:for-each>
            reverse: 1
            singleton: 0
            name: <xsl:text>`</xsl:text><xsl:value-of select="@name"/><xsl:text>`</xsl:text>
            description:  <xsl:value-of select="description"/>
            variables:
            assert:
            subtype:
            lastChangeOid:
            adminStatusExpression:
            operStatusExpression:<xsl:for-each select="indicators/indicator">
            INDICATOR:
                indicator: <xsl:value-of select="@name"/>
                description: <xsl:value-of select="description"/>
                expression: .<xsl:value-of select="oid"/>
                type: <xsl:variable name="syntaxType" select="snmpSyntax/@type"/>
                       <xsl:choose>
                           <xsl:when test="$syntaxType='Gauge32' or $syntaxType='Gauge64'">GAUGE</xsl:when>
                           <xsl:when test="$syntaxType='Counter32'">COUNTER32</xsl:when>
                           <xsl:when test="$syntaxType='Counter64'">COUNTER64</xsl:when>
                       </xsl:choose>
                default: 1
                dataunits: ChangeMe {Number,Percent,Bytes,Bits...}
                percentable: ChangeMe{0 or 1}
                max: ChangeMe
                maxunits: ChangeMe {Number,Percent,Bytes,Bits...}
                units:</xsl:for-each>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>