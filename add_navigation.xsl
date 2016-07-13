<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:h="http://www.w3.org/1999/xhtml" 
    xmlns="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="xs h"
    version="2.0">
    
    <xsl:param name="part" />
    <xsl:param name="section" />
    
    <xsl:variable name="page" select="substring-before($part, '.')" />
    <xsl:variable name="page-num" select="replace($page, '^[^\d]*(\d+).*', '$1')" />
    
    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="h:a[@class='ref']">
        <xsl:variable name="id" select="replace(replace(@href, '-note-', '-ref-'), '^#', '')"/>
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:attribute name="id" select="$id" />
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="h:a[@class='note']">
        <xsl:variable name="href" select="replace(@href, '-note-', '-ref-')"/>
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:attribute name="href" select="$href" />
            <xsl:apply-templates select="node()" />
        </xsl:copy>
    </xsl:template>
        
    
    <xsl:template match="h:title">
        <xsl:variable name="title" select="/h:html/h:body/h:div[1]/h:span[1][@style='font-size:10px;vertical-align:baseline;color:#101e8e;']" />
        <xsl:copy>
            <xsl:value-of select="normalize-space($title)" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="h:body/h:div[1]">
        <div style="position:relative; left:55px;font-family:sans-serif;font-weight: bold;color:#101e8e;font-size:10px;">
            <span><a href="page{xs:int($page-num) - 1}.html">Previous page</a></span> | 
            <span><a href="index.html">Contents</a></span> | 
            <span><a href="page{xs:int($page-num) + 1}.html">Next page</a></span>
        </div>
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="h:body/h:div[last()]">
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:apply-templates />
        </xsl:copy>
        <div style="position:relative; left:400px;top:800px;font-family:sans-serif;font-weight: bold;color:#101e8e;font-size:10px">
            <span><a href="page{xs:int($page-num) - 1}.html">Previous page</a></span> | 
            <span><a href="index.html">Contents</a></span> | 
            <span><a href="page{xs:int($page-num) + 1}.html">Next page</a></span>
        </div>
    </xsl:template>
</xsl:stylesheet>