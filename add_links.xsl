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
    
    <xsl:template match="* | @* | text()">
        <xsl:copy>
            <xsl:apply-templates select="node() | @* except @id" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates />
        <xsl:variable name="toc">
            <xsl:apply-templates mode="toc" select="descendant::h:span" />
        </xsl:variable>
        <xsl:result-document href="../toc/{$page}-toc.html" omit-xml-declaration="true" exclude-result-prefixes="#all" indent="true">
            <div>
                <!-- TODO need to do some grouping so we can wrap paragraph number blocks in details tags -->
                <ul>
                    <xsl:copy-of select="$toc" />
                </ul>
            </div>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="h:span" mode="toc" />
    
    <!-- TOC h1-->
    <xsl:template match="h:span[@style='font-size:18px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]" mode="toc">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <li>
            <a href="{$part}#{$id}"><xsl:value-of select="normalize-space(.)" /></a>
        </li>
    </xsl:template>
    
    <!--TOC h2 -->
    <xsl:template match="h:span[@style='font-size:16px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]" mode="toc">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <li style="margin-left: 6pt;">
            <a href="{$part}#{$id}"><xsl:value-of select="normalize-space(.)" /></a>
        </li>
    </xsl:template>
    
    <!-- TOC h3 -->
    <xsl:template match="h:span[@style='font-size:14px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]" mode="toc">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <li style="margin-left: 12pt;">
            <a href="{$part}#{$id}"><xsl:value-of select="normalize-space(.)" /></a>
        </li>
    </xsl:template>
    
    <!-- TOC h4 -->
    <xsl:template match="h:span[@style='font-size:12px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]" mode="toc">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <li style="margin-left: 18pt;">
            <a href="{$part}#{$id}"><xsl:value-of select="normalize-space(.)" /></a>
        </li>
    </xsl:template>
    
    <!-- TOC numbered para -->
    <xsl:template match="h:span[@style='font-size:12px;vertical-align:super;color:#101e8e;'][matches(., '^\d+\.?\s*')]" priority="10" mode="toc">
        <xsl:variable name="id" select="concat($page, '-para-', replace(., '^(\d+).*', '$1'))"/>
        <li style="margin-left: 24pt;">
            <a href="{$part}#{$id}"><xsl:value-of select="normalize-space(.)" /></a>
        </li>
    </xsl:template>
    
    <!-- h1 -->
    <xsl:template match="h:span[@style='font-size:18px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="h1" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- h2 -->
    <xsl:template match="h:span[@style='font-size:16px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="h2" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- h3 -->
    <xsl:template match="h:span[@style='font-size:14px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="h3" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- h4 -->
    <xsl:template match="h:span[@style='font-size:12px;vertical-align:baseline;color:#101e8e;'][matches(., '\p{L}{2,}')]">
        <xsl:variable name="id" select="concat($page, '-', lower-case(replace(normalize-space(.), '\s+', '_')))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="h4" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- numbered para -->
    <xsl:template match="h:span[@style='font-size:12px;vertical-align:super;color:#101e8e;'][matches(., '^\d+\.?\s*')]" priority="10">
        <xsl:variable name="id" select="concat($page, '-para-', replace(., '^(\d+).*', '$1'))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="para" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- footnote ref -->
    <xsl:template match="h:span[@style='font-size:6px;vertical-align:super;color:#000000;'][matches(., '^\d+')]" priority="10">
        <xsl:variable name="id" select="concat($page, '-note-', replace(., '^(\d+).*', '$1'))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="ref" href="#{$id}">
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
    <!-- footnote itself -->
    <xsl:template match="h:span[@style='font-size:5px;vertical-align:super;color:#000000;'][matches(., '^\d+')]" priority="10">
        <xsl:variable name="id" select="concat($page, '-note-', replace(., '^(\d+).*', '$1'))"/>
        <xsl:copy>
            <xsl:copy-of select="@* except @id" />
            <a class="note" href="#{$id}">
                <xsl:attribute name="id" select="$id"/>
                <xsl:apply-templates select="node()" />
            </a>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>