<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd">
    
    <xd:doc>
        <xd:desc>
            <xd:p>Fixes for super-and-subscript in content/</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="sub | subscript | inf">
        <xsl:value-of
            select="
            translate(.,
            '0123456789+-−=()aehijklmnoprstuvxəβγρφχ',
            '₀₁₂₃₄₅₆₇₈₉₊₋₋₌₍₎ₐₑₕᵢⱼₖₗₘₙₒₚᵣₛₜᵤᵥₓₔᵦᵧᵨᵩᵪ')"
        />
    </xsl:template>
    
    <xsl:template match="sup | superscript">
        <xsl:value-of
            select="
            translate(.,
            '0123456789+-−=()abcdefghijklmnoprstuvwxyzABDEGHIJKLMNOPRTUVWαβγδεθɩφχ',
            '⁰¹²³⁴⁵⁶⁷⁸⁹⁺⁻⁻⁼⁽⁾ᵃᵇᶜᵈᵉᶠᵍʰⁱʲᵏˡᵐⁿᵒᵖʳˢᵗᵘᵛʷˣʸᶻᴬᴮᴰᴱᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᴿᵀᵁⱽᵂᵅᵝᵞᵟᵋᶿᶥᵠᵡ')"
        />
    </xsl:template>
    
    
    <xd:doc>
        <xd:desc>
            <xd:p>Add a space at the end of content within paragraph tags.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="p">
        <xsl:variable name="this"><xsl:apply-templates/></xsl:variable>
        <xsl:value-of select="concat($this, ' ')"/>
    </xsl:template>
</xsl:stylesheet>