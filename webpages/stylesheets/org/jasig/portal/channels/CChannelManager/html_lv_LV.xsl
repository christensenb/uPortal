<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="no"/>
  <xsl:param name="baseActionURL">render.userLayoutRootNode.uP</xsl:param>
  <xsl:param name="locale">lv_LV</xsl:param>
  <xsl:param name="action">defaultView</xsl:param>
  <xsl:param name="stepID">1</xsl:param>
  <xsl:param name="errorMsg">no parameter passed</xsl:param>
  <xsl:variable name="mediaPath">media/org/jasig/portal/channels/CChannelManager</xsl:variable>
  <xsl:variable name="defaultLength">10</xsl:variable>
  <xsl:variable name="defaultMaxLength">20</xsl:variable>
  <xsl:variable name="defaultTextCols">40</xsl:variable>
  <xsl:variable name="defaultTextRows">10</xsl:variable>



  <xsl:template match="/">
<!--    <html>
      <head>
        <link rel="stylesheet" href="C:\portal\webpages\media\org\jasig\portal\layout\tab-column\nested-tables\imm\skin\imm.css" type="text/css"/>
      <xsl:comment></xsl:comment>
      </head>
      <body>-->

        <xsl:choose>
          <xsl:when test="$action='selectChannelType'">
            <xsl:call-template name="selectChannelType"/>
          </xsl:when>
          <xsl:when test="$action='selectGeneralSettings'">
            <xsl:call-template name="selectGeneralSettings"/>
          </xsl:when>
          <xsl:when test="$action='selectModifyChannel'">
            <xsl:call-template name="selectModifyChannel"/>
          </xsl:when>
          <xsl:when test="$action='channelDef'">
            <xsl:call-template name="beginChannelDef"/>
          </xsl:when>
          <xsl:when test="$action='selectControls'">
            <xsl:call-template name="selectControls"/>
          </xsl:when>
          <xsl:when test="$action='selectCategories'">
            <xsl:call-template name="selectCategories"/>
          </xsl:when>
          <xsl:when test="$action='selectCategoriesButtons'">
            <xsl:call-template name="selectCategoriesButtons"/>
          </xsl:when>
          <xsl:when test="$action='selectGroups'">
            <xsl:call-template name="selectGroups"/>
          </xsl:when>
          <xsl:when test="$action='selectGroupsButtons'">
            <xsl:call-template name="selectGroupsButtons"/>
          </xsl:when>
          <xsl:when test="$action='reviewChannel'">
            <xsl:call-template name="reviewChannel"/>
          </xsl:when>
          <xsl:when test="$action='customSettings'">
            <xsl:call-template name="customSettings"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="defaultView"/>
          </xsl:otherwise>
        </xsl:choose>
<!--      </body>
    </html>-->
  </xsl:template>
  <xsl:template name="defaultView">
    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-channel-text">
            <tr class="uportal-channel-strong" valign="top">
              <td colspan="2" class="uportal-channel-text">Opcijas kanālu administrēšanai:</td>
            </tr>
            <tr valign="top">
              <td colspan="2">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16"/>
              </td>
            </tr>
            <tr class="uportal-channel-text" valign="top">
              <td>
                <img alt="saskarnes attēls" src="{$mediaPath}/bullet.gif" width="16" height="16"/>
              </td>
              <td width="100%" class="uportal-channel-text">
                <a href="{$baseActionURL}?uPCM_action=selectChannelType">Publicēt jaunu kanālu</a>
              </td>
            </tr>
            <tr valign="top">
              <td>
                <img alt="saskarnes attēls" src="{$mediaPath}/bullet.gif" width="16" height="16"/>
              </td>
              <td class="uportal-channel-text" width="100%">
                <a href="{$baseActionURL}?uPCM_action=selectModifyChannel">Modificēt publicēto kanālu</a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="selectChannelType">
    <xsl:call-template name="workflow"/>
    <!-- form begin -->
    <form name="workflow" method="post" action="{$baseActionURL}">
      <input type="hidden" name="uPCM_action" value="none"/>
      <input type="hidden" name="uPCM_capture" value="selectChannelType"/>
      <input type="hidden" name="uPCM_step" value="changeMe"/>
      <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
        <tr class="uportal-channel-text">
          <td>
            <strong>Kanāla tips:</strong> Izvēlieties kanāla tipu</td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="2" class="uportal-background-content" cellspacing="0">
              <tr>
                <td nowrap="nowrap" class="uportal-channel-table-header">Opcija</td>
                <td nowrap="nowrap" class="uportal-channel-table-header">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td nowrap="nowrap" class="uportal-channel-table-header">Kanāla tips</td>
                <td nowrap="nowrap" class="uportal-channel-table-header">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td width="100%" class="uportal-channel-table-header">Apraksts</td>
              </tr>
              <tr class="uportal-channel-text" valign="top">
                <td nowrap="nowrap" colspan="5">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              <tr class="uportal-channel-text" valign="top">
                <td nowrap="nowrap" align="center">
                  <input type="radio" name="ID" value="-1">
                  <xsl:if test="manageChannels/selectChannelType/params/step/channel/@typeID=-1 or not(manageChannels/selectChannelType/params/step/channel/@typeID)">
                  <xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input>
                </td>
                <td nowrap="nowrap">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                </td>
                <td nowrap="nowrap">
                  <strong>Izveidojams</strong>
                </td>
                <td nowrap="nowrap">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                </td>
                <td width="100%">Šis kanāla tips ļauj publicēt kanālus bez KPD (kanālu publicēšanas dokumenta). Tas parasti tiek lietots, lai publicētu kanālus tikai ar vienu kanālam atbilstošo definīciju.</td>
              </tr>

                <tr class="uportal-channel-text" valign="top">
                  <td colspan="5" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                      <tr>
                        <td>
                          <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>

                <tr class="uportal-channel-text" valign="top">
                  <td colspan="5" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                      <tr>
                        <td>
                          <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>

              <xsl:for-each select="//selectChannelType//channelType">
              <xsl:sort select="name"/>
                <tr class="uportal-channel-text" valign="top">
                  <td nowrap="nowrap" align="center">
                    <input type="radio" name="ID" value="{@ID}">
                    <xsl:if test="@ID=../../channel/@typeID">
                     <xsl:attribute name="checked">checked</xsl:attribute></xsl:if></input> </td>
                  <td nowrap="nowrap">
                    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                  </td>
                  <td nowrap="nowrap">
                    <strong>
                      <xsl:value-of select="name"/>
                    </strong>
                  </td>
                  <td nowrap="nowrap">
                    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                  </td>
                  <td width="100%">
                    <xsl:value-of select="description"/>
                  </td>
                </tr>
                <tr class="uportal-channel-text" valign="top">
                  <td colspan="5" align="center">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                      <tr>
                        <td>
                          <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </xsl:for-each>




            </table>
          </td>
        </tr>
        <tr>
          <td>
            <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectGeneralSettings'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/> </td>
        </tr>
      </table>
    </form>
    <!-- form end -->
  </xsl:template>

  <xsl:template name="selectModifyChannel">
  <xsl:variable name="filterByID"><xsl:value-of select="//filterByID[1]"/></xsl:variable>
  <xsl:variable name="recsPerPage" select="number(//recordsPerPage)"/>
  <xsl:variable name="currPage" select="number(//currentPage)"/>
  <xsl:variable name="pageIdNodeSet" select="//*[@ID=$filterByID]//channel"/>
  <xsl:variable name="maxPages" select="ceiling(count($pageIdNodeSet[not(@ID=preceding::channel/@ID)]) div $recsPerPage)"/>

    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-channel-text">
            <tr class="uportal-channel-strong" valign="top">
              <td colspan="2">Modificēt publicēto kanālu:</td>
            </tr>
            <tr valign="top">
              <td colspan="2">Izvēlēties opciju</td>
            </tr>
            <tr class="uportal-channel-text" valign="top">
              <td colspan="2">
                <a href="#">
                </a>
                <hr/>
              </td>
            </tr>
            <tr valign="top">
              <td>
                <img alt="saskarnes attēls" src="{$mediaPath}/bullet.gif" width="16" height="16"/>
              </td>
              <td class="uportal-channel-text" width="100%">
                <a href="{$baseActionURL}?uPCM_action=cancel">Atcelt un atgriezties</a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br/>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="uportal-background-light">
      <tr class="uportal-channel-text" valign="top">
          <td nowrap="nowrap">
            <xsl:call-template name="pagingWidget">
              <xsl:with-param name="i" select="1"/>
              <xsl:with-param name="currPage" select="$currPage"/>
              <xsl:with-param name="maxPages" select="$maxPages"/>
            </xsl:call-template>
          </td>
          <form method="post" action="{$baseActionURL}">
          <input type="hidden" name="uPCM_action" value="filterByCategory"/>
          <td width="100%" class="uportal-background-med">Filtrēt pēc kategorijas:<xsl:for-each select="//*[@ID = $filterByID]">
          <xsl:for-each select="ancestor::category">
          <a class="uportal-navigation-category-selected"><xsl:attribute name="href">
          <xsl:value-of select="$baseActionURL"/>?uPCM_action=filterByCategory&amp;newCategory=<xsl:value-of select="@ID"/></xsl:attribute>
                  <em>
                    <xsl:value-of select="@name"/>
                  </em></a>::</xsl:for-each>
              <a href="#" class="uportal-navigation-category-selected">
                <em>
                  <xsl:value-of select="@name"/>
                </em>
              </a>--<select name="newCategory" class="uportal-input-text" size="1"><option value="{@ID}" selected="selected"/><xsl:for-each select="child::category"><xsl:sort select="@name"/><option value="{@ID}"><xsl:value-of select="@name"/></option></xsl:for-each>
                <option value=" ">_________</option>
                <option>
                  <xsl:attribute name="value">
                    <xsl:value-of select="//registry[1]/@ID"/>
                  </xsl:attribute>Bez filtra</option></select>
              <input type="submit" name="uPCM_submit" value="aiziet" class="uportal-input-text"/></xsl:for-each>
          </td>
          </form>
      </tr>
      <tr>
        <td colspan="2">
          <table width="100%" border="0" cellpadding="2" class="uportal-background-content" cellspacing="0">
            <xsl:choose>
              <xsl:when test="(//*[@ID = $filterByID]//channel)">
                <tr class="uportal-channel-table-header">
                  <td colspan="2" align="center" valign="top">Opcija</td>
                  <td nowrap="nowrap" valign="top">
                    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                  </td>
                  <td nowrap="nowrap" valign="top">Kanāla nosaukums</td>
                  <td valign="top">
                    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                  </td>
                  <td width="100%" valign="top">Apraksts</td>
                </tr>
                <tr class="uportal-channel-text" valign="top">
                  <td nowrap="nowrap" colspan="6">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                      <tr>
                        <td>
                          <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="2"/>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <xsl:for-each select="(//*[@ID = $filterByID]//channel[not(@ID=preceding::channel/@ID)])">
                  <xsl:sort select="@name"/>
                  <xsl:if test="(position() &gt; ($recsPerPage * $currPage)-$recsPerPage) and (position() &lt;= $recsPerPage * $currPage)">
                    <tr class="uportal-channel-text" valign="top">
                      <td nowrap="nowrap" align="center">
                        <a href="{$baseActionURL}?uPCM_action=editChannelSettings&amp;channelID={@ID}">
                          <img src="{$mediaPath}/edit.gif" width="16" height="16" border="0" alt="Rediģēt {@ID} iestatījumus"/>
                        </a>
                      </td>
                      <td nowrap="nowrap" align="center">
                        <a href="{$baseActionURL}?uPCM_action=removePublishedChannel&amp;channelID={@ID}">
                          <img src="{$mediaPath}/remove.gif" width="16" height="16" border="0" alt="Izmest publicēto kanālu - {@ID}" onclick="return confirm('You are about to remove this channel as well as its role and category settings!\nAre you sure you want to do this?')"/>
                        </a>
                      </td>
                      <td valign="top">
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                      <td nowrap="nowrap" valign="top">
                        <strong>
                          <xsl:value-of select="@name"/>
                        </strong>
                      </td>
                      <td valign="top">
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                      <td width="100%" valign="top">
                        <xsl:value-of select="@description"/>
                      </td>
                    </tr>
                    <tr class="uportal-channel-text" valign="top">
                      <td colspan="6" align="center">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                          <tr>
                            <td>
                              <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </xsl:if>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <tr class="uportal-channel-table-header">
                  <td colspan="3" valign="top" nowrap="nowrap">
                    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16"/>Nav kanālu, ko parādīt</td>
                </tr>
              </xsl:otherwise>
            </xsl:choose>
          </table>
        </td>
      </tr>
      <tr class="uportal-channel-text">
        <form name="formRecordsDisplayed" method="post" action="{$baseActionURL}">
          <input type="hidden" name="uPCM_action" value="changeRecordsPerPage"/>
          <input type="hidden" name="uPCM_step" value="changeMe"/>
          <td nowrap="nowrap" valign="top">
            <xsl:call-template name="pagingWidget">
              <xsl:with-param name="i" select="1"/>
              <xsl:with-param name="currPage" select="$currPage"/>
              <xsl:with-param name="maxPages" select="$maxPages"/>
            </xsl:call-template>
          </td>
          <td width="100%" class="uportal-background-med" valign="top">Rādīt<input type="text" name="recordsPerPage" size="2" class="uportal-input-text"><xsl:attribute name="value"><xsl:value-of select="$recsPerPage"/></xsl:attribute></input>ierakstus.<img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16"/><input type="submit" name="buttonRecordsDisplayed" value="aiziet" class="uportal-button"/></td>
        </form>
      </tr>
    </table>
  </xsl:template>
  <xsl:template name="pagingWidget">
    <xsl:param name="i"/>
    <xsl:param name="currPage"/>
    <xsl:param name="maxPages"/>

    <xsl:if test="$i &lt;= $maxPages">
      <xsl:if test="$i = 1">lapa:</xsl:if>
      <xsl:if test="($i = 1) and ($currPage=1)">
        <img src="{$mediaPath}/arrow_left_off.gif" width="16" height="16" alt="Iepriekšējais" border="0"/>
        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4"/>
      </xsl:if>
      <xsl:if test="($i = 1) and ($currPage &gt; 1)">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$baseActionURL"/>?uPCM_action=changePage&amp;newPage=<xsl:value-of select="($currPage)-1"/></xsl:attribute>
          <img src="{$mediaPath}/arrow_left.gif" width="16" height="16" ID="left" alt="Go to page [{($currPage)-1}]" border="0"/>
        </a>
        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4"/>
      </xsl:if>
      <xsl:if test="$i = $currPage">
        <strong>
          <xsl:value-of select="$i"/>
        </strong>
        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4"/>
      </xsl:if>
      <xsl:if test="$i != $currPage">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$baseActionURL"/>?uPCM_action=changePage&amp;newPage=<xsl:value-of select="$i"/></xsl:attribute>
          <xsl:value-of select="$i"/>
        </a>
        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4"/>
      </xsl:if>
      <xsl:if test="($i = $maxPages) and ($currPage = $maxPages)">
        <img src="{$mediaPath}/arrow_right_off.gif" width="16" height="16" alt="Nākamais" border="0"/>
      </xsl:if>
      <xsl:if test="($i = $maxPages) and ($currPage &lt; $maxPages)">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$baseActionURL"/>?uPCM_action=changePage&amp;newPage=<xsl:value-of select="($currPage)+1"/></xsl:attribute>
          <img src="{$mediaPath}/arrow_right.gif" width="16" height="16" ID="right" alt="Doties uz lapu [{($currPage)+1}]" border="0"/>
        </a>
      </xsl:if>
      <xsl:call-template name="pagingWidget">
        <xsl:with-param name="i" select="$i + 1"/>
        <xsl:with-param name="currPage" select="$currPage"/>
        <xsl:with-param name="maxPages" select="$maxPages"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  <xsl:template name="workflow">
    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-channel-text">

            <tr class="uportal-channel-strong" valign="top">
              <td colspan="2">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16"/>
              </td>
            </tr>
            <tr valign="top">
              <td colspan="2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="uportal-channel-table-header" nowrap="nowrap">Darba plūsma:<img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="10" height="10"/></td>
                    <xsl:apply-templates select="manageChannels//step" mode="workflow"/>
                  </tr>
                </table>
              </td>
            </tr>
            <tr class="uportal-channel-text" valign="top">
              <td colspan="2">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16"/>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br/>
  </xsl:template>

  <xsl:template match="manageChannels//step" mode="workflow">

    <xsl:if test="name(../../.)=$action and ID = $stepID">
      <xsl:for-each select="preceding::step">
        <xsl:if test="position() != 1">
          <td width="{round(100 div count(//step))}%">
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr>
                <td class="uportal-background-shadow">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                </td>
              </tr>
            </table>
          </td>
        </xsl:if>
        <td>
          <table border="0" cellspacing="0" cellpadding="1" class="uportal-background-shadow">
            <tr>
              <td>
                <table border="0" cellspacing="0" cellpadding="2" class="uportal-background-med">
                  <tr>
                    <td class="uportal-text-small" align="center">
                      <a>
                        <xsl:attribute name="href">javascript:document.workflow.uPCM_action.value='<xsl:value-of select="name(../../.)"/>';document.workflow.uPCM_step.value='<xsl:value-of select="ID"/>';document.workflow.submit()</xsl:attribute>
                        <xsl:choose>
                          <xsl:when test="normalize-space(name) !=''"><xsl:value-of select="name"/></xsl:when>
                          <xsl:otherwise>Kanāla parametri</xsl:otherwise>
                        </xsl:choose>
                      </a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </xsl:for-each>
      <xsl:if test="position() != 1">
        <td width="{round(100 div count(//step))}%">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="uportal-background-shadow">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
              </td>
            </tr>
          </table>
        </td>
      </xsl:if>
      <td>
        <img alt="saskarnes attēls" src="{$mediaPath}/arrow_right_timeline.gif"/>
      </td>
      <td>
        <table border="0" cellspacing="0" cellpadding="1" class="uportal-background-dark">
          <tr>
            <td>
              <table border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
                <tr>
                  <td class="uportal-text-small" align="center">
                    <a><xsl:attribute name="href">javascript:document.workflow.uPCM_action.value='<xsl:value-of select="name(.)"/>';document.workflow.uPCM_step.value='<xsl:value-of select="$stepID"/>';document.workflow.submit()</xsl:attribute>
                        <xsl:choose>
                          <xsl:when test="normalize-space(name) != ''"><xsl:value-of select="name"/></xsl:when>
                          <xsl:otherwise>Kanāla parametri</xsl:otherwise>
                        </xsl:choose>
                    </a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
      <xsl:for-each select="following::step">
        <td width="{round(100 div count(//step))}%">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="uportal-background-med">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
              </td>
            </tr>
          </table>
        </td>
        <td>
          <table border="0" cellspacing="0" cellpadding="1" class="uportal-background-dark">
            <tr>
              <td>
                <table border="0" cellspacing="0" cellpadding="2" class="uportal-background-light" width="8">
                  <tr>
                    <td class="uportal-text-small" align="center">
                      <a>
                        <xsl:attribute name="href">javascript:document.workflow.uPCM_action.value='<xsl:value-of select="name(../../.)"/>';document.workflow.uPCM_step.value='<xsl:value-of select="ID"/>';document.workflow.submit()</xsl:attribute>
                        <xsl:choose>
                          <xsl:when test="normalize-space(name)!='' "><xsl:value-of select="name"/></xsl:when>
                          <xsl:otherwise>Kanāla parametri</xsl:otherwise>
                        </xsl:choose>
                      </a>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template name="selectGeneralSettings">
    <xsl:call-template name="workflow"/>

    <form name="workflow" method="post" action="{$baseActionURL}">
      <input type="hidden" name="uPCM_action" value="none"/>
      <input type="hidden" name="uPCM_capture" value="selectGeneralSettings"/>
      <input type="hidden" name="uPCM_step" value="changeMe"/>
      <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
        <tr class="uportal-channel-text">
          <td>
            <strong>Iestatījumi [one]:</strong> Izvēlēties iestatījumus</td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
              <tr class="uportal-channel-table-header" valign="bottom">
                <!--<td align="center" nowrap="nowrap">Lietotājs var<br/> modificēt?</td>-->

                <td align="center" nowrap="nowrap">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>Opcijas
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/></td>
                <td>
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td width="100%">Vispārējie iestatījumi</td>
              </tr>
              
              <tr class="uportal-channel-table-header">
                <td align="center" colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              
              <!-- Channel Title -->
              <tr>
                <td align="center" valign="top">
                  <a href="javascript:alert('Nosaukums: Garais nosaukums\n\nPiemērs: Akciju cenu diagramma\n\nApraksts: Šis ir kanāla garais nosaukums. Tas parādās kā kanāla virsraksts. Parasti kanāla garais nosaukums un nosaukums sakrīt.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla garais nosaukums:</span> <span class="uportal-text-small">[piemērs - StockCharts]<br/>
                  <input type="text" name="title" size="50" class="uportal-input-text">
                    <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@title">
                     <xsl:attribute name="value"><xsl:value-of select="manageChannels/selectGeneralSettings/params/step/channel/@title"/></xsl:attribute></xsl:if></input>
                  </span> </td>
              </tr>
              
              <tr class="uportal-channel-text">
                <td align="center" valign="top" colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              
              <!-- Channel name -->
              <tr>
                <td align="center" valign="top">
                  <a href="javascript:alert('Name: Channel Name\n\nPiemērs: Akciju cenu diagramma\n\nApraksts: Šis ir kanāla nosaukums. Izvēloties šo kanālu, lietotāji redzēs šādu nosaukumu. Parasti kanāla garais nosaukums un nosaukums sakrīt.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla nosaukums:</span> <span class="uportal-text-small">[piemērs - StockCharts]<br/>
                  <input type="text" name="name" size="50" class="uportal-input-text">
                    <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@name">
                     <xsl:attribute name="value"><xsl:value-of select="manageChannels/selectGeneralSettings/params/step/channel/@name"/></xsl:attribute></xsl:if></input>
                  </span> </td>
              </tr>
              
              <tr class="uportal-channel-text">
                <td align="center" valign="top" colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              
              <!-- Channel fname -->
              <tr>
                <td align="center" valign="top">
                  <a href="javascript:alert('Nosaukums: Kanāla funkcionālais nosaukums\n\nPiemērs: stock-charts\n\nApraksts: This is the functional name of the channel used for identification for JNDI lookups and web services.  The channel functional name should uniquely identify this channel definition.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla funkcionālais nosaukums:</span> <span class="uportal-text-small">[piemērs - stock-charts]<br/>
                  <input type="text" name="fname" size="50" class="uportal-input-text">
                    <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@fname">
                     <xsl:attribute name="value"><xsl:value-of select="manageChannels/selectGeneralSettings/params/step/channel/@fname"/></xsl:attribute></xsl:if></input>
                  </span> </td>
              </tr>
              
              <tr class="uportal-channel-text">
                <td align="center" valign="top" colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
               
              <!-- Channel Description -->
              <tr>
                <td align="center" valign="top">
                  <a href="javascript:alert('Nosaukums: Kanāla apraksts\n\nPiemērs: Akciju cenu diagramma ir finansu pakalpojumu kanāls, kas piedāvā tādus pakalpojumus kā, piemēram, akciju cenu izmaiņas laikā.\n\nApraksts: This is the description of the channel that is used when it is helpful to provide additional information to a user about a channel.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla apraksts:</span><br/>
                  <textarea name="description" cols="50" rows="3" class="uportal-input-text">
                    <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@description">
                      <xsl:value-of select="manageChannels/selectGeneralSettings/params/step/channel/@description"/>
                    </xsl:if>
                  </textarea>
                </td>
              </tr>
              
              <tr class="uportal-channel-text">
                <td align="center" valign="top" colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Channel Timeout -->
              <tr class="uportal-channel-text">
                <!--<td align="center" valign="top">
                  <input type="checkbox" name="modifyTimeout" value="checkbox"/>
                </td>-->
                 <td align="center" valign="top">
                  <a href="javascript:alert('Nosaukums: Kanāla taimauts\n\nPiemērs: 10000\n\nApraksts: This is the number of milliseconds a channel will be given to render itself before the portal terminates that channels rendering.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla taimauts:</span> <br/>
                   <input type="text" name="timeout" size="6" class="uportal-input-text">
                                       <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@timeout">
                     <xsl:attribute name="value"><xsl:value-of select="manageChannels/selectGeneralSettings/params/step/channel/@timeout"/></xsl:attribute></xsl:if></input>
                   milisekundes (1000 = 1 sekunde)</td>
              </tr>
              
              <tr>
                <td colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Channel Secure -->
              <tr class="uportal-channel-text">
                <!--<td align="center" valign="top">
                  <input type="checkbox" name="modifySecure" value="checkbox"/>
                </td>-->
                 <td align="center" valign="top">
                  <a href="javascript:alert('Nosaukums: Kanāls ir drošs\n\nApraksts: Šī opcija nosaka, ka kanālu iespējams apskatīt tikai caur https protokolu.')">
                  <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
                  </a></td>
                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāls ir drošs:</span><br/>
                    <input type="checkbox" name="secure" class="uportal-input-text">
                      <xsl:if test="manageChannels/selectGeneralSettings/params/step/channel/@secure = 'true'">
                        <xsl:attribute name="checked">
                          checked
                        </xsl:attribute>
                      </xsl:if>
                    </input>
		</td>
              </tr>
              
              <tr>
                <td colspan="3">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Channel Java Class -->
              <xsl:choose>
                <xsl:when test="/manageChannels/selectGeneralSettings/params/step/channel/@typeID = -1">
                <tr class="uportal-channel-text">
                <!--<td align="center" valign="top">
                  <input type="checkbox" name="modifyTimeout" value="checkbox"/>
                </td>-->
                <td align="center" valign="top">
    <a href="javascript:alert('Nosaukums: Kanāla klase\n\nPiemērs: edu.myuniversity.portal.channels.myChannel.MyChannelClass\n\nApraksts: Šī ir Java klase izveidotam kanālam. Kanāla klase ir obligāta')">
    <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
    </a></td>

                <td>
                </td>
                <td>
                  <span class="uportal-label">Kanāla klase:</span> <br/>
                   <input type="text" name="class" size="50" class="uportal-input-text">
                                       <xsl:if test="/manageChannels/selectGeneralSettings/params/step/channel/@class">
                     <xsl:attribute name="value"><xsl:value-of select="/manageChannels/selectGeneralSettings/params/step/channel/@class"/></xsl:attribute></xsl:if></input></td>
              </tr>
              
              <tr>
                <td colspan="2">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
                </xsl:when>
                <xsl:otherwise>
                  <input type="hidden" name="class" value="{/manageChannels/channelDef/class}"/>
                </xsl:otherwise>
              </xsl:choose>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectChannelType'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='channelParams'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/> </td>
        </tr>
      </table>
    </form>
    <!-- form end -->
  </xsl:template>

  <xsl:template name="beginChannelDef">
    <xsl:call-template name="workflow"/>
    <xsl:choose>
    <xsl:when test="manageChannels/channelDef/params/step[ID=$stepID]/arbitrary-parameters">
    <xsl:apply-templates select="manageChannels/channelDef[1]" mode="arbitrarySettings"/>
    </xsl:when>
    <xsl:otherwise>
    <xsl:apply-templates select="manageChannels/channelDef[1]" mode="dynamicSettings"/>
    </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <xsl:template match="channelDef" mode="dynamicSettings">
    <!-- form begin -->
    <form name="workflow" method="post" action="{$baseActionURL}">
      <input type="hidden" name="uPCM_action" value="changeMe"/>
      <input type="hidden" name="uPCM_capture" value="channelDef"/>
      <input type="hidden" name="uPCM_step" value="changeMe"/>
      <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
        <tr class="uportal-channel-text">
          <td>
            <strong>
            <xsl:choose>
            <xsl:when test="normalize-space(params/step[position()=$stepID]/name) != ''">
              <xsl:value-of select="params/step[position()=$stepID]/name"/>
            </xsl:when>
            <xsl:otherwise>Soļa nosaukums</xsl:otherwise></xsl:choose>:</strong>
            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8"/>
                        <xsl:choose>
            <xsl:when test="normalize-space(params/step[position()=$stepID]/description) != ''">
              <xsl:value-of select="params/step[position()=$stepID]/description"/>
            </xsl:when>
            <xsl:otherwise>Apraksts</xsl:otherwise></xsl:choose>
          </td>
        </tr>
        <tr>
          <td>

            <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
              <tr class="uportal-channel-table-header" valign="bottom">
                <td align="center" nowrap="nowrap">
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>Opcijas
                <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/></td>

                <td align="center" nowrap="nowrap">Lietotājs var<br/> modificēt?</td>
                <td>
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td width="100%">Vispārējie iestatījumi</td>
              </tr>
              <tr class="uportal-channel-table-header">
                <td align="center" colspan="4">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <xsl:apply-templates select="params/step[ID=$stepID]"/>
            </table>

          </td>
        </tr>
        <tr>
        
          <td>
            <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" class="uportal-button">
              <xsl:attribute name="onclick">
                <xsl:choose>
                  <xsl:when test="$stepID = 1">document.workflow.uPCM_action.value='selectGeneralSettings';document.workflow.uPCM_step.value='<xsl:value-of select="$stepID"/>'</xsl:when>
                  <xsl:otherwise>document.workflow.uPCM_action.value='channelParams';document.workflow.uPCM_step.value='<xsl:value-of select="number($stepID) - 1"/>'</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </input>
            <input type="submit" name="uPCM_submit" value="Nākamais &gt;" class="uportal-button">
              <xsl:attribute name="onclick">
                <xsl:choose>
                  <xsl:when test="$stepID = count(params/step)">document.workflow.uPCM_action.value='selectControls';document.workflow.uPCM_step.value='<xsl:value-of select="$stepID"/>'</xsl:when>
                  <xsl:otherwise>document.workflow.uPCM_action.value='channelParams';document.workflow.uPCM_step.value='<xsl:value-of select="number($stepID) + 1"/>'</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </input>
            <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/> 
          </td>
        </tr>
      </table>
    </form>
    <!-- form end -->
  </xsl:template>

  <xsl:template match="channelDef" mode="arbitrarySettings">
  <xsl:variable name="prefix" select="params/step/arbitrary-parameters/paramName-prefix[1]"/>
  <xsl:variable name="prefixLength" select="string-length(params/step/arbitrary-parameters/paramName-prefix[1])"/>

<table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">

        <tr class="uportal-channel-text">
          <td>
            <strong>
            <xsl:choose>
            <xsl:when test="normalize-space(params/step[position()=$stepID]/name) != ''">
              <xsl:value-of select="params/step[position()=$stepID]/name"/>
            </xsl:when>
            <xsl:otherwise>Soļa nosaukums</xsl:otherwise></xsl:choose>:</strong>
            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8"/>
                        <xsl:choose>
            <xsl:when test="normalize-space(params/step[position()=$stepID]/description) != ''">
              <xsl:value-of select="params/step[position()=$stepID]/description"/>
            </xsl:when>
            <xsl:otherwise>Apraksts</xsl:otherwise></xsl:choose>
          </td>
        </tr>

      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
            <tr valign="top">
              <td class="uportal-label">

                <form name="addParameter" method="post" action="{$baseActionURL}">
                  <input type="hidden" name="uPCM_action" value="customSettings"/>
                  <input type="hidden" name="uPCM_capture" value="customSettings"/>
                  <input type="hidden" name="uPCM_subAction" value="addParameter"/>
                  <input type="hidden" name="uPCM_step" value="{$stepID}"/>
                  <input type="hidden" name="uPCM_namePrefix" value="{params/step[position()=$stepID]/arbitrary-parameters[1]/paramName-prefix[1]}"/>

                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                  <tr class="uportal-label">
                    <td>Nosaukums:<br />
                     <input type="text" name="name" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>Vērtība:<br />
                     <input type="text" name="value" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>
                     <input type="checkbox" name="override" value="checkbox"/>
                     <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" />
                     Lietotājs var modificēt?
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td align="right"><input type="submit" name="uPCM_submit" value="pievienot" class="uportal-button" /></td>
                  </tr>
                </table>
                </form>
              </td>

              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
              <td class="uportal-background-light"><img alt="saskarnes attēls" src="transparent.gif" width="2" height="2" /></td>
              <td width="100%">

                <table width="100%" border="0" cellpadding="2" class="uportal-background-content" cellspacing="0">
                  <tr>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Opcija</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Lietotājs var<br/>modificēt?</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Nosaukums</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="8" height="8" /></td>
                    <td width="100%" class="uportal-channel-table-header">Vērtība</td>
                  </tr>

                  <tr class="uportal-channel-text" valign="top">
                    <td nowrap="nowrap" colspan="7">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                        <tr>
                          <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="2" /></td>
                        </tr>
                      </table>
                    </td>
                  </tr>

                  <xsl:choose>
                    <xsl:when test="params/step[ID=$stepID]/channel/parameter[substring(@name,1,$prefixLength)=$prefix]">
                      <xsl:for-each select="params/step[ID=$stepID]/channel/parameter[substring(@name,1,$prefixLength)=$prefix]">
                        <tr class="uportal-channel-text" valign="top">
                          <td nowrap="nowrap" align="center">
                            <a href="{$baseActionURL}?uPCM_action=customSettings&amp;uPCM_capture=customSettings&amp;uPCM_subAction=deleteParameter&amp;name={@name}&amp;uPCM_step={$stepID}"><img src="{$mediaPath}/remove.gif" width="16" height="16" border="0" alt="Noņemt šo parametru"/></a>
                          </td>
                          <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                                                    <td nowrap="nowrap" align="center">
                          <xsl:choose><xsl:when test="@override ='yes'"><img alt="saskarnes attēls" src="{$mediaPath}/checked.gif" width="16" height="16" /></xsl:when>
                          <xsl:otherwise><img alt="saskarnes attēls" src="{$mediaPath}/check.gif" width="16" height="16" /></xsl:otherwise></xsl:choose>
                          </td>
                                                    <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                          <td nowrap="nowrap"><strong><xsl:value-of select="substring(@name,$prefixLength+1)"/></strong></td>
                          <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                          <td width="100%"><xsl:value-of select="@value"/></td>
                        </tr>
                        <tr class="uportal-channel-text" valign="top">
                          <td colspan="7" align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                              <tr><td><img alt="saskarnes attēls" src="transparent.gif" width="1" height="1" /></td></tr>
                            </table>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr class="uportal-channel-text" valign="top">
                        <td colspan="5" align="left">Nav parametru</td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </table>

              </td>
            </tr>
          </table>
        </td>
      </tr>
<!--      <tr>
        <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="none"/>
        <input type="hidden" name="uPCM_capture" value="customSettings"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectGeneralSettings'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectControls'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/>
        </td>
        </form>
      </tr>-->
      <tr>
            <form name="workflow" method="post" action="{$baseActionURL}">
      <input type="hidden" name="uPCM_action" value="changeMe"/>
      <input type="hidden" name="uPCM_capture" value="channelDef"/>
      <input type="hidden" name="uPCM_step" value="changeMe"/>
          <td>
            <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" class="uportal-button">
              <xsl:attribute name="onclick">
                <xsl:choose>
                  <xsl:when test="$stepID = 1">document.workflow.uPCM_action.value='selectGeneralSettings';document.workflow.uPCM_step.value='<xsl:value-of select="$stepID"/>'</xsl:when>
                  <xsl:otherwise>document.workflow.uPCM_action.value='channelParams';document.workflow.uPCM_step.value='<xsl:value-of select="number($stepID) - 1"/>'</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </input>
            <input type="submit" name="uPCM_submit" value="Nākamais &gt;" class="uportal-button">
              <xsl:attribute name="onclick">
                <xsl:choose>
                  <xsl:when test="$stepID = count(params/step)">document.workflow.uPCM_action.value='selectControls';document.workflow.uPCM_step.value='<xsl:value-of select="$stepID"/>'</xsl:when>
                  <xsl:otherwise>document.workflow.uPCM_action.value='channelParams';document.workflow.uPCM_step.value='<xsl:value-of select="number($stepID) + 1"/>'</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </input>
            <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/> 
          </td></form>
        </tr>
    </table>

</xsl:template>

  <!-- The current step info-->
  <xsl:template match="step">
    <xsl:apply-templates select="parameter"/>
  </xsl:template>

  <!-- Display the parameters that are NOT subscribe-only-->
  <xsl:template match="parameter">
    <xsl:if test="@modify != 'subscribe-only'">
    <xsl:choose>
    <xsl:when test="type/@display != 'hidden'">
      <tr>
<td align="center" valign="top">
<xsl:call-template name="help"/>
</td>
        <xsl:choose>
          <xsl:when test="type/@input='text'">
            <xsl:call-template name="text"/>
          </xsl:when>
          <xsl:when test="type/@input='single-choice'">
            <xsl:call-template name="single-choice"/>
          </xsl:when>
          <xsl:when test="type/@input='multi-choice'">
            <xsl:call-template name="multi-choice"/>
          </xsl:when>
        </xsl:choose>
      </tr>
      <tr class="uportal-channel-table-header">
                <td align="center" colspan="4">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td>
                        <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
    </xsl:when>
    <xsl:otherwise>
            <xsl:choose>
          <xsl:when test="type/@input='text'">
            <xsl:call-template name="text"/>
          </xsl:when>
          <xsl:when test="type/@input='single-choice'">
            <xsl:call-template name="single-choice"/>
          </xsl:when>
          <xsl:when test="type/@input='multi-choice'">
            <xsl:call-template name="multi-choice"/>
          </xsl:when>
        </xsl:choose>
    </xsl:otherwise></xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- displays checkbox for publisher to allow subscribe time modification-->
  <xsl:template name="subscribe">
<xsl:param name="paramName"/>

    <td align="center" valign="top">
      <xsl:choose>

      <xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name=$paramName]/@override = 'yes'">
      <input type="checkbox" name="uPCM_{name}_sub" checked='checked'/></xsl:when>

      <xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name=$paramName]/@override = 'no'">
      <input type="checkbox" name="uPCM_{name}_sub"/></xsl:when>

      <xsl:when test="@modify!='publish-only'">
          <input type="checkbox" name="uPCM_{name}_sub">
            <xsl:if test="@modify='subscribe'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
        </xsl:when>
        <xsl:otherwise>
          <img alt="saskarnes attēls" src="{$mediaPath}/nocheck.gif" width="16" height="16"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
    <td/>
  </xsl:template>
  <!-- display all the input fields with a base type of 'single-choice'-->
  <xsl:template name="single-choice">
    <xsl:choose>
      <xsl:when test="type/@display='drop-down'">
        <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
<select name="{name}" class="uportal-input-text">
            <xsl:for-each select="type/restriction/value">
            <xsl:variable name="name"><xsl:value-of select="../../../name"/></xsl:variable>
            <xsl:variable name="value"><xsl:value-of select="."/></xsl:variable>


              <option value="{.}">

<xsl:choose>
<xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name = $name]">
<xsl:if test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name = $name]/@value = $value">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
</xsl:when>

<xsl:otherwise>
<xsl:if test=". = ../defaultValue[1]"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
</xsl:otherwise>

</xsl:choose>


                <xsl:choose>
                  <xsl:when test="@display">
                    <xsl:value-of select="@display"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>

              </option>

            </xsl:for-each>

          </select>
        </td>
      </xsl:when>
      <xsl:when test="type/@display='radio'">
        <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <xsl:for-each select="type/restriction/value">
            <input type="radio" name="{name}" value="{.}" class="uportal-input-text">
              <xsl:if test=". = ../defaultValue[1]">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
            <xsl:choose>
              <xsl:when test="@display">
                <xsl:value-of select="@display"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <select name="{name}" class="uportal-input-text">
            <xsl:for-each select="type/restriction/value">
                      <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
              <option value="{.}">
                <xsl:if test=". = ../defaultValue[1]">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="@display">
                    <xsl:value-of select="@display"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- display all the input fields with a base type of 'multi-choice'-->
  <xsl:template name="multi-choice">
    <xsl:choose>
      <xsl:when test="type/@display='select-list'">
                <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <select name="{name}" size="6" multiple="multiple" class="uportal-input-text">
            <xsl:for-each select="type/restriction/value">
              <option value="{.}">
                <xsl:if test=". = ../defaultValue[1]">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="@display">
                    <xsl:value-of select="@display"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </xsl:when>
      <xsl:when test="type/@display='checkbox'">
                <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <xsl:for-each select="type/restriction/value">
            <input type="checkbox" name="{name}" value="{.}">
              <xsl:if test=". = ../defaultValue[1]">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
            <xsl:choose>
              <xsl:when test="@display">
                <xsl:value-of select="@display"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </td>
      </xsl:when>
      <xsl:otherwise>
                <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <select name="{name}" size="6" multiple="multiple" class="uportal-input-text">
            <xsl:for-each select="type/restriction/value">
              <option value="{.}">
                <xsl:if test=". = ../defaultValue[1]">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:choose>
                  <xsl:when test="@display">
                    <xsl:value-of select="@display"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="."/>
                  </xsl:otherwise>
                </xsl:choose>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- display all the input fields with a base type of 'text'-->
  <xsl:template name="text">
    <!-- since length and maxlength are not required test existence and use defaults if needed -->
    <xsl:variable name="length">
      <xsl:choose>
        <xsl:when test="type/length"> <xsl:value-of select="type/length"/> </xsl:when>
        <xsl:otherwise> <xsl:value-of select="$defaultLength"/> </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="maxlength">
      <xsl:choose>
        <xsl:when test="type/maxlength"> <xsl:value-of select="type/maxlength"/> </xsl:when>
        <xsl:otherwise> <xsl:value-of select="$defaultMaxLength"/> </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="type/@display='text'">
          <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>



          <input type="text" name="{name}" maxlength="{$maxlength}" size="{$length}" class="uportal-input-text">
          <xsl:choose>
          <xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter/@name = name">
          <xsl:variable name="name"><xsl:value-of select="name"/></xsl:variable>
          <xsl:attribute name="value"><xsl:value-of select="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name = $name]/@value"/>
          </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
          <xsl:attribute name="value"><xsl:value-of select="defaultValue"/></xsl:attribute>
          </xsl:otherwise>
          </xsl:choose>
          </input>
          <xsl:apply-templates select="units"/>


        </td>
      </xsl:when>
      <xsl:when test="type/@display='textarea'">
                <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <textarea rows="{$defaultTextRows}" cols="{$defaultTextCols}" class="uportal-input-text">
            <xsl:choose>
              <xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter/@name = name">
                <xsl:variable name="name"><xsl:value-of select="name"/></xsl:variable>
                <xsl:value-of select="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name = $name]/@value"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="defaultValue"/>
              </xsl:otherwise>
            </xsl:choose>
          </textarea>
        </td>
      </xsl:when>
      <xsl:when test="type/@display='hidden'">
        <input type="hidden" name="{name}" value="{defaultValue}"/>
      </xsl:when>
      <xsl:otherwise>
                <xsl:call-template name="subscribe">
          <xsl:with-param name="paramName">
          <xsl:value-of select="name"/>
          </xsl:with-param>
          </xsl:call-template>
        <td class="uportal-text-small">
          <xsl:apply-templates select="label"/>
          <xsl:apply-templates select="example"/>
          <br/>
          <input type="text" name="{name}" maxlength="{$maxlength}" size="{$length}" class="uportal-input-text">
          <xsl:choose>
          <xsl:when test="/manageChannels/channelDef/params/step[$stepID]/channel/parameter/@name = name">
          <xsl:variable name="name"><xsl:value-of select="name"/></xsl:variable>
          <xsl:attribute name="value"><xsl:value-of select="/manageChannels/channelDef/params/step[$stepID]/channel/parameter[@name = $name]/@value"/>
          </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
          <xsl:attribute name="value"><xsl:value-of select="defaultValue"/></xsl:attribute>
          </xsl:otherwise>
          </xsl:choose>
          </input>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="label">
    <span class="uportal-label">
      <xsl:value-of select="."/>:</span>
  </xsl:template>

  <xsl:template match="example">
    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8"/>
    <span class="uportal-text-small">[piemērs - <xsl:value-of select="."/>]</span>
  </xsl:template>

    <xsl:template match="units">
    <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8"/>
    <span class="uportal-text-small"><xsl:value-of select="."/></span>
  </xsl:template>

      <xsl:template name="help">
    <a>
    <xsl:attribute name="href">
    javascript:alert('Name: <xsl:value-of select="label"/>\n\nPiemērs: <xsl:value-of select="example"/>\n\nApraksts: <xsl:value-of select="description"/>')</xsl:attribute>
    <img src="{$mediaPath}/help.gif" width="16" height="16" border="0" alt="Rādīt palīginformāciju"/>
    </a>
  </xsl:template>

  <xsl:template name="selectControls">
    <xsl:call-template name="workflow"/>
    <!-- form begin -->
    <form name="workflow" method="post" action="{$baseActionURL}">
      <input type="hidden" name="uPCM_action" value="changeMe"/>
      <input type="hidden" name="uPCM_capture" value="selectControls"/>
      <input type="hidden" name="uPCM_step" value="changeMe"/>

      <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
        <tr class="uportal-channel-text">
          <td>
            <strong>Kanāla kontroles elementi:</strong>
            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4"/>Izvēlēties kanāla kontroles elementus</td>
        </tr>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
              <tr class="uportal-channel-table-header">
                <td align="center">Izvēlēties</td>
                <td align="center">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td nowrap="nowrap" align="center">Kanāla kontroles elementi</td>
                <td nowrap="nowrap" align="center">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td nowrap="nowrap" align="center">Ikona</td>
                <td align="center">
                  <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="8"/>
                </td>
                <td width="100%">Apraksts</td>
              </tr>

              <tr class="uportal-channel-table-header">
                <td align="center" colspan="7">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="2" height="2"/></td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Edit control -->
              <xsl:choose>
              <xsl:when test="not(/manageChannels/channelDef) or /manageChannels/channelDef/controls/control[@type='edit']/@override='yes'">
              <tr class="uportal-channel-text">
                <td align="center" valign="top">
                  <input type="checkbox" name="editable" value="true">
                  <xsl:choose>
                    <xsl:when test="/manageChannels/selectControls/params/step/channel/@editable">
                      <xsl:if test="/manageChannels/selectControls/params/step/channel/@editable='true'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="/manageChannels/channelDef/controls/control[@type='edit']/@include='yes'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                  </input>
                </td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td><strong>Rediģējams</strong></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/edit.gif" width="16" height="16"/></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td>kad iezīmēts, iniciē izmaiņas</td>
              </tr>

              </xsl:when>
              <xsl:otherwise>
                <tr class="uportal-channel-text">
                  <td align="center" valign="top">
                    <xsl:choose>
                      <xsl:when test="/manageChannels/channelDef/controls/control[@type='edit']/@include='yes'">
                        <input type="hidden" name="editable" value="true"/>
                        <img alt="checked" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/>
                      </xsl:when>
                      <xsl:otherwise><img alt="check" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/></xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td><strong>Rediģējams</strong></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/edit.gif" width="16" height="16"/></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td>kad iezīmēts, iniciē izmaiņas</td>
                </tr>
              </xsl:otherwise>
              </xsl:choose>


              <!-- separator line -->
              <tr>
                <td align="center" valign="top" colspan="7">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/></td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- Help control -->
              <xsl:choose>
              <xsl:when test="not(/manageChannels/channelDef) or /manageChannels/channelDef/controls/control[@type='help']/@override='yes'">
              <tr class="uportal-channel-text">
                <td align="center" valign="top">
                  <input type="checkbox" name="hasHelp" value="true">
                  <xsl:choose>
                    <xsl:when test="/manageChannels/selectControls/params/step/channel/@hasHelp">
                      <xsl:if test="/manageChannels/selectControls/params/step/channel/@hasHelp='true'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="/manageChannels/channelDef/controls/control[@type='help']/@include='yes'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                  </input>
                </td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td><strong>Pieejama palīdzība</strong></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/help.gif" width="16" height="16"/></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td>when selected, passes help events</td>
              </tr>

              </xsl:when>
              <xsl:otherwise>
                <tr class="uportal-channel-text">
                  <td align="center" valign="top">
                     <xsl:choose>
                      <xsl:when test="/manageChannels/channelDef/controls/control[@type='help']/@include='yes'">
                        <input type="hidden" name="hasHelp" value="true"/>
                        <img alt="checked" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/>
                      </xsl:when>
                      <xsl:otherwise><img alt="check" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/></xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td><strong>Pieejama palīdzība</strong></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/help.gif" width="16" height="16"/></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td>when selected, passes help events</td>
                </tr>
              </xsl:otherwise>
              </xsl:choose>


              <!-- separator line -->
              <tr>
                <td align="center" valign="top" colspan="7">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                    <tr>
                      <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1"/></td>
                    </tr>
                  </table>
                </td>
              </tr>

              <!-- About control -->
              <xsl:choose>
              <xsl:when test="not(/manageChannels/channelDef) or /manageChannels/channelDef/controls/control[@type='about']/@override='yes'">
              <tr class="uportal-channel-text">
                <td align="center" valign="top">
                  <input type="checkbox" name="hasAbout" value="true">
                  <xsl:choose>
                    <xsl:when test="/manageChannels/selectControls/params/step/channel/@hasAbout">
                      <xsl:if test="/manageChannels/selectControls/params/step/channel/@hasAbout='true'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="/manageChannels/channelDef/controls/control[@type='about']/@include='yes'">
                        <xsl:attribute name="checked">checked</xsl:attribute>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                  </input>
                </td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td><strong>iezīmēts, iniciē palīdzību</strong></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/about.gif" width="16" height="16"/></td>
                <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                <td>iezīmēts, iniciē informāciju</td>
              </tr>

              </xsl:when>
              <xsl:otherwise>
                <tr class="uportal-channel-text">
                  <td align="center" valign="top">
                    <xsl:choose>
                      <xsl:when test="/manageChannels/channelDef/controls/control[@type='about']/@include='yes'">
                        <input type="hidden" name="hasAbout" value="true"/>
                        <img alt="checked" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/>
                      </xsl:when>
                      <xsl:otherwise><img alt="check" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/></xsl:otherwise>
                    </xsl:choose>
                  </td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td><strong>iezīmēts, iniciē palīdzību</strong></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td align="center"><img alt="saskarnes attēls" src="{$mediaPath}/about.gif" width="16" height="16"/></td>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif"/></td>
                  <td>iezīmēts, iniciē informāciju</td>
                </tr>
              </xsl:otherwise>
              </xsl:choose>

            </table>
          </td>
        </tr>
        <tr>
          <td>
            <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='channelParams';document.workflow.uPCM_step.value='{count(//channelDef//step)}'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectCategories'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
            <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/> </td>
        </tr>
      </table>
    </form>
    <!-- form end -->
  </xsl:template>

  <xsl:template name="selectCategories">
    <xsl:variable name="catID">
      <xsl:value-of select="//browsingCategory[1]"/>
    </xsl:variable>

    <xsl:call-template name="workflow"/>
  </xsl:template>

  <xsl:template name="selectCategoriesButtons">
    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="changeMe"/>
        <input type="hidden" name="uPCM_capture" value="selectCategories"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>

      <tr>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectControls'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectGroups'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/>
        </td>
      </tr>

      </form>
    </table>
  </xsl:template>

  <xsl:template name="reviewChannel">
      <xsl:call-template name="workflow"/>

    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">

      <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="changeMe"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>
      <tr class="uportal-channel-text">
        <td><strong>Pārskats:</strong> Lūdzu pārbaudīt iestatījumu pareizību (nospiest darba plūsmas pogu vai kādu no izvēlnēm tabulā lai mainītu iestatījumus)</td>
      </tr>
      <!-- Display an error message when appropriate -->
      <xsl:if test="$errorMsg='NO_CATEGORIES'"><tr><td class="uportal-channel-error">Please select at least one category before continuing.</td></tr></xsl:if>
      <xsl:if test="$errorMsg='NO_GROUP_MEMBERS'"><tr><td class="uportal-channel-error">Please select at least one group and/or person before continuing.</td></tr></xsl:if>
      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">

            <tr class="uportal-channel-table-header" valign="bottom">
              <td nowrap="nowrap" align="center">Lietotājs var<br />
                modificēt?</td>
              <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
              <td nowrap="nowrap">Nosaukums</td>
              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
              <td width="100%">Vērtība</td>
            </tr>

            <tr class="uportal-channel-text">
              <td nowrap="nowrap" colspan="5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                  <tr>
                    <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="2" /></td>
                  </tr>
                </table>
             </td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectChannelType&amp;uPCM_capture=reviewChannel">Kanāla tips:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectChannelType&amp;uPCM_capture=reviewChannel">
               <xsl:value-of select="//selectChannelType/params/step/channelTypes/channelType[@ID=/manageChannels/reviewChannel/params/step/channel/@typeID]/name"/></a></td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
               </table>
             </td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla garais nosaukums:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@title"/></a></td>
           </tr>
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
               </table>
             </td>
           </tr>
           
           <!-- Channel name -->
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla nosaukums:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@name"/></a></td>
           </tr>
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
               </table>
             </td>
           </tr>
           
           <!-- Channel fname -->
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla funkcionālais nosaukums:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@fname"/></a></td>
           </tr>
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
               </table>
             </td>
           </tr>           

           <!-- Channel Description -->           
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla apraksts:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@description"/></a></td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
               </table>
             </td>
           </tr>

           <!-- Channel Timeout -->
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla taimauts:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@timeout"/>
               <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/>milisekundes</a></td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
              </table>
            </td>
          </tr>

           <!-- Channel Secure -->
           <tr class="uportal-channel-text">
             <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
             <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāls ir drošs:</a></strong></td>
             <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
             <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">
             <xsl:choose>
               <xsl:when test="/manageChannels/reviewChannel/params/step/channel/@secure = 'true'"><img alt="Drošs" title="Drošs" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/></xsl:when>
               <xsl:otherwise><img alt="Nav drošs" title="Nav drošs" src="{$mediaPath}/check.gif" width="16" height="16" border="0" /></xsl:otherwise>
             </xsl:choose></a></td>
           </tr>

           <tr class="uportal-channel-text">
             <td nowrap="nowrap" colspan="5">
               <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                 <tr>
                   <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                 </tr>
              </table>
            </td>
          </tr>

           <!-- Kanāla parametri -->
          <xsl:choose>
            <xsl:when test="/manageChannels/reviewChannel/params/step/channel/@typeID = -1">

          <tr class="uportal-channel-text">
            <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /> </td>
            <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel">Kanāla klase:</a></strong></td>
            <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td width="100%"><a href="{$baseActionURL}?uPCM_action=selectGeneralSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="/manageChannels/reviewChannel/params/step/channel/@class"/></a></td>
          </tr>
          <tr class="uportal-channel-text">
            <td nowrap="nowrap" colspan="5">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                <tr>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                </tr>
              </table>
            </td>
          </tr>
          <xsl:for-each select="/manageChannels/reviewChannel/params/step/channel/parameter">
          <tr class="uportal-channel-text">
            <td nowrap="nowrap" align="center"><a href="{$baseActionURL}?uPCM_action=customSettings&amp;uPCM_capture=reviewChannel">
            <xsl:choose>
              <xsl:when test="@override = 'yes'"><img alt="Lietotājs var modificēt" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/></xsl:when>
              <xsl:otherwise><img alt="Lietotājs nevar modificēt" src="{$mediaPath}/check.gif" width="16" height="16" border="0" /></xsl:otherwise>
            </xsl:choose></a>
            </td>
            <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=customSettings&amp;uPCM_capture=reviewChannel">Parametrs:</a></strong></td>
            <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td width="100%"><a href="{$baseActionURL}?uPCM_action=customSettings&amp;uPCM_capture=reviewChannel"><xsl:value-of select="@name"/> = <xsl:value-of select="@value"/></a></td>
          </tr>
          <tr class="uportal-channel-text">
            <td nowrap="nowrap" colspan="5">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                <tr>
                  <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                </tr>
              </table>
            </td>
          </tr>
          </xsl:for-each>
          </xsl:when>

          <xsl:otherwise>
          <xsl:for-each select="/manageChannels/reviewChannel/params/step/channel/parameter">
          <xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
          <xsl:variable name="value"><xsl:value-of select="@value"/></xsl:variable>

          <xsl:choose>
          <xsl:when test="/manageChannels/channelDef/params/step/parameter[name=$name]/type/@display != 'hidden'">
          <tr class="uportal-channel-text">
            <td nowrap="nowrap" align="center"><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={//parameter/name[.=$name]/../../ID}">
            <xsl:choose><xsl:when test="@override = 'yes'">
            <img alt="Lietotājs var modificēt" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/></xsl:when>
            <xsl:otherwise><img alt="Lietotājs nevar modificēt" src="{$mediaPath}/check.gif" width="16" height="16" border="0" /></xsl:otherwise></xsl:choose></a>
            </td>
            <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={//parameter/name[.=$name]/../../ID}"><xsl:value-of select="//parameter/name[.=$name]/../label"/></a></strong></td>
            <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td width="100%"><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={//parameter/name[.=$name]/../../ID}">
            <xsl:choose><xsl:when test="@value = //channelDef//restriction/value and //channelDef//restriction/value[.=$value]/@display"><xsl:value-of select="//channelDef//restriction/value[.=$value]/@display"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise></xsl:choose>
            </a></td>
            </tr>
            <tr class="uportal-channel-text">
            <td nowrap="nowrap" colspan="5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
            <tr>
              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
            </tr>
            </table>
            </td>
          </tr>
          </xsl:when>

          <xsl:when test="/manageChannels/channelDef/params/step/parameter[name=$name]/type/@display = 'hidden'"></xsl:when>

          <xsl:when test="/manageChannels/channelDef/params/step/arbitrary-parameters">
          <xsl:variable name="firstArbParamID" select="/manageChannels/channelDef/params/step[arbitrary-parameters][1]/ID"/>
          <tr class="uportal-channel-text">
            <td nowrap="nowrap" align="center"><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={$firstArbParamID}">
            <xsl:choose>
            <xsl:when test="@override = 'yes'">
            <img alt="Lietotājs var modificēt" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/></xsl:when>
            <xsl:otherwise>
            <img alt="Lietotājs nevar modificēt" src="{$mediaPath}/check.gif" width="16" height="16" border="0" />
            </xsl:otherwise>
            </xsl:choose></a></td>
            <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={$firstArbParamID}"><xsl:value-of select="@name"/></a></strong></td>
            <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
            <td width="100%"><a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=reviewChannel&amp;uPCM_step={$firstArbParamID}"><xsl:value-of select="@value"/></a></td>
            </tr>
            <tr class="uportal-channel-text">
            <td nowrap="nowrap" colspan="5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
            <tr>
              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
            </tr>
            </table>
            </td>
          </tr>
          </xsl:when>
          </xsl:choose>

      </xsl:for-each>
</xsl:otherwise>


</xsl:choose>

      <tr class="uportal-channel-text">

        <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>

        <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>

        <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectControls&amp;uPCM_capture=reviewChannel">Kanāla kontroles elementi</a></strong></td>



        <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>



        <td><a href="{$baseActionURL}?uPCM_action=selectControls&amp;uPCM_capture=reviewChannel">

        <xsl:choose>
          <xsl:when test="//reviewChannel//channel[@editable='true']"><img alt="true" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:when>
          <xsl:otherwise><img alt="false" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:otherwise>
        </xsl:choose>
        Rediģējams<br/>

        <xsl:choose>
          <xsl:when test="//reviewChannel//channel[@hasHelp='true']"><img alt="true" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:when>
          <xsl:otherwise><img alt="false" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:otherwise>
        </xsl:choose>
        Pieejama palīdzība<br/>

        <xsl:choose>
          <xsl:when test="//reviewChannel//channel[@hasAbout='true']"><img alt="true" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:when>
          <xsl:otherwise><img alt="false" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:otherwise>
        </xsl:choose>
        iezīmēts, iniciē palīdzību<br/>

        <!--
        <xsl:choose>
          <xsl:when test="//reviewChannel//channel[@printable='true']"><img alt="true" src="{$mediaPath}/checked.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:when>
          <xsl:otherwise><img alt="false" src="{$mediaPath}/check.gif" width="16" height="16" border="0"/><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" border="0"/></xsl:otherwise>
        </xsl:choose>
        Printable<br/>
        -->

        </a>

        </td>

      </tr>



      <tr class="uportal-channel-text">

        <td nowrap="nowrap" colspan="5">

          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">

            <tr>

              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>

            </tr>

          </table>

        </td>

      </tr>



      <tr class="uportal-channel-text">

        <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>



        <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>



        <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectCategories&amp;uPCM_capture=reviewChannel">Izvēlētās kategorijas:</a></strong></td>



        <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>



        <td ><a href="{$baseActionURL}?uPCM_action=selectCategories&amp;uPCM_capture=reviewChannel">

        <xsl:for-each select="//selectedCategory">
          <img alt="saskarnes attēls" src="{$mediaPath}/category.gif" width="16" height="16" border="0" /><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8" border="0"  />
          <xsl:value-of select="@name"/>
          <br/>
        </xsl:for-each>

        </a>

        </td>

      </tr>



      <tr class="uportal-channel-text">

        <td nowrap="nowrap" colspan="5">

          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">

            <tr>

              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>

            </tr>

          </table>

        </td>

      </tr>

      <!-- Selected groups/people -->
      <tr class="uportal-channel-text">
        <td nowrap="nowrap" align="center"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
        <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
        <td nowrap="nowrap" valign="top"><strong><a href="{$baseActionURL}?uPCM_action=selectGroups&amp;uPCM_capture=reviewChannel">Izvēlētās grupas un/vai cilvēki</a></strong></td>
        <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
        <td>
          <a href="{$baseActionURL}?uPCM_action=selectGroups&amp;uPCM_capture=reviewChannel">
            <xsl:for-each select="//selectedGroup">
              <img alt="saskarnes attēls" src="{$mediaPath}/unlocked.gif" width="16" height="16" border="0" /><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="8" height="8" border="0"/>
              <xsl:value-of select="@name"/>
              <br/>
            </xsl:for-each>
          </a>
        </td>
      </tr>

      <tr class="uportal-channel-text">

        <td nowrap="nowrap" colspan="5">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
            <tr>
              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
        </td>
      </tr>
      <tr>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectGroups'" class="uportal-button" />
          <input type="submit" name="uPCM_submit" value="Pabeigts" onclick="document.workflow.uPCM_action.value='finished'" class="uportal-button" />
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button" />
        </td>
      </tr>

      </form>

    </table>
  </xsl:template>

  <xsl:template name="customSettings">
    <xsl:call-template name="workflow"/>
    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <tr class="uportal-channel-text">
        <td><strong>Pievienot parametrus:</strong> Pievienot kanāla parametrus</td>
      </tr>

      <tr>
        <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
            <tr valign="top">
              <td class="uportal-label">

                <form name="addParameter" method="post" action="{$baseActionURL}">
                  <input type="hidden" name="uPCM_action" value="customSettings"/>
                  <input type="hidden" name="uPCM_capture" value="customSettings"/>
                  <input type="hidden" name="uPCM_subAction" value="addParameter"/>
                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                  <tr class="uportal-label">
                    <td>Nosaukums:<br />
                     <input type="text" name="name" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>Vērtība:<br />
                     <input type="text" name="value" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>
                     <input type="checkbox" name="override" value="checkbox"/>
                     <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" />
                     Lietotājs var modificēt?
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td align="right"><input type="submit" name="uPCM_submit" value="pievienot" class="uportal-button" /></td>
                  </tr>
                </table>
                </form>
              </td>

              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
              <td class="uportal-background-light"><img alt="saskarnes attēls" src="transparent.gif" width="2" height="2" /></td>
              <td width="100%">

                <table width="100%" border="0" cellpadding="2" class="uportal-background-content" cellspacing="0">
                  <tr>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Opcija</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Lietotājs var<br/>modificēt?</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Nosaukums</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="8" height="8" /></td>
                    <td width="100%" class="uportal-channel-table-header">Vērtība</td>
                  </tr>

                  <tr class="uportal-channel-text" valign="top">
                    <td nowrap="nowrap" colspan="7">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                        <tr>
                          <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="2" /></td>
                        </tr>
                      </table>
                    </td>
                  </tr>

                  <xsl:choose>
                    <xsl:when test="manageChannels/customSettings/params/step/channel/parameter">
                      <xsl:for-each select="manageChannels/customSettings/params/step/channel/parameter">
                        <tr class="uportal-channel-text" valign="top">
                          <td nowrap="nowrap" align="center">
                            <a href="{$baseActionURL}?uPCM_action=customSettings&amp;uPCM_capture=customSettings&amp;uPCM_subAction=deleteParameter&amp;name={@name}"><img src="{$mediaPath}/remove.gif" width="16" height="16" border="0" alt="Noņemt šo parametru"/></a>
                          </td>
                          <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                                                    <td nowrap="nowrap" align="center">
                          <xsl:choose><xsl:when test="@override ='yes'"><img alt="saskarnes attēls" src="{$mediaPath}/checked.gif" width="16" height="16" /></xsl:when>
                          <xsl:otherwise><img alt="saskarnes attēls" src="{$mediaPath}/check.gif" width="16" height="16" /></xsl:otherwise></xsl:choose>
                          </td>
                                                    <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                          <td nowrap="nowrap"><strong><xsl:value-of select="@name"/></strong></td>
                          <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                          <td width="100%"><xsl:value-of select="@value"/></td>
                        </tr>
                        <tr class="uportal-channel-text" valign="top">
                          <td colspan="7" align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                              <tr><td><img alt="saskarnes attēls" src="transparent.gif" width="1" height="1" /></td></tr>
                            </table>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr class="uportal-channel-text" valign="top">
                        <td colspan="5" align="left">Nav parametru</td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </table>

              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="none"/>
        <input type="hidden" name="uPCM_capture" value="customSettings"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectGeneralSettings'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectControls'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/>
        </td>
        </form>
      </tr>
    </table>
  </xsl:template>

<xsl:template name="arbitraryParameters">

          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="uportal-background-content">
            <tr valign="top">
              <td class="uportal-label">

                <form name="addParameter" method="post" action="{$baseActionURL}">
                  <input type="hidden" name="uPCM_action" value="channelDef"/>
                  <input type="hidden" name="uPCM_capture" value="customSettings"/>
                  <input type="hidden" name="uPCM_subAction" value="addParameter"/>
                  <input type="hidden" name="uPCM_step" value="{$stepID}"/>
                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                  <tr class="uportal-label">
                    <td>Nosaukums:<br />
                     <input type="text" name="name" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>Vērtība:<br />
                     <input type="text" name="value" class="uportal-input-text" />
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td>
                     <input type="checkbox" name="override" value="checkbox"/>
                     <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="4" height="4" />
                     Lietotājs var modificēt?
                    </td>
                  </tr>

                  <tr class="uportal-label">
                    <td align="right"><input type="submit" name="uPCM_submit" value="pievienot" onclick="document.addParameter.name.value='{/manageChannels/channelDef/params/step[position()=$stepID]/arbitrary-parameters/paramName-prefix[1]}' + document.addParameter.name.value" class="uportal-button" /></td>
                  </tr>
                </table>
                </form>
              </td>

              <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="16" height="16" /></td>
              <td class="uportal-background-light"><img alt="saskarnes attēls" src="transparent.gif" width="2" height="2" /></td>
              <td width="100%">

                <table width="100%" border="0" cellpadding="2" class="uportal-background-content" cellspacing="0">
                  <tr>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Opcija</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Lietotājs var<br/>modificēt?</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="16" height="8" /></td>
                    <td nowrap="nowrap" class="uportal-channel-table-header">Nosaukums</td>
                    <td nowrap="nowrap" class="uportal-channel-table-header"><img alt="saskarnes attēls" src="transparent.gif" width="8" height="8" /></td>
                    <td width="100%" class="uportal-channel-table-header">Vērtība</td>
                  </tr>

                  <tr class="uportal-channel-text" valign="top">
                    <td nowrap="nowrap" colspan="7">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                        <tr>
                          <td><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="2" /></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                  <xsl:variable name="prefix" select="/manageChannels/channelDef/params/step/arbitrary-parameters/paramName-prefix"/>
                  <xsl:variable name="prefixLength" select="string-length($prefix)"/>
                  <xsl:choose>         
                    <xsl:when test="/manageChannels/channelDef/params/step/channel/parameter[substring(@name,1,$prefixLength)=$prefix]">
                      <xsl:for-each select="/manageChannels/channelDef/params/step/channel/parameter[substring(@name,1,$prefixLength)=$prefix]">
                        <tr class="uportal-channel-text" valign="top">
                          <td nowrap="nowrap" align="center">
                            <a href="{$baseActionURL}?uPCM_action=channelDef&amp;uPCM_capture=customSettings&amp;uPCM_subAction=deleteParameter&amp;name={@name}"><img src="{$mediaPath}/remove.gif" width="16" height="16" border="0" alt="Noņemt šo parametru"/></a>
                          </td>
                          <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                                                    <td nowrap="nowrap" align="center">
                          <xsl:choose><xsl:when test="@override ='yes'"><img alt="saskarnes attēls" src="{$mediaPath}/checked.gif" width="16" height="16" /></xsl:when>
                          <xsl:otherwise><img alt="saskarnes attēls" src="{$mediaPath}/check.gif" width="16" height="16" /></xsl:otherwise></xsl:choose>
                          </td>
                                                    <td nowrap="nowrap">
                            <img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" />
                          </td>
                          <td nowrap="nowrap"><strong><xsl:value-of select="substring(@name,$prefixLength+1)"/></strong></td>
                          <td nowrap="nowrap"><img alt="saskarnes attēls" src="{$mediaPath}/transparent.gif" width="1" height="1" /></td>
                          <td width="100%"><xsl:value-of select="@value"/></td>
                        </tr>
                        <tr class="uportal-channel-text" valign="top">
                          <td colspan="7" align="center">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="uportal-background-light">
                              <tr><td><img alt="saskarnes attēls" src="transparent.gif" width="1" height="1" /></td></tr>
                            </table>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr class="uportal-channel-text" valign="top">
                        <td colspan="5" align="left">Nav parametru</td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </table>

              </td>
            </tr>
          </table>
<!--        </td>
      </tr>
      <tr>
        <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="none"/>
        <input type="hidden" name="uPCM_capture" value="customSettings"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectGeneralSettings'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='selectControls'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/>
        </td>
        </form>
      </tr>
    </table> -->
  </xsl:template>

<xsl:template name="selectGroups">
    <xsl:variable name="groupID">
      <xsl:value-of select="//browsingGroup[1]"/>
    </xsl:variable>

    <xsl:call-template name="workflow"/>

</xsl:template>

<xsl:template name="selectGroupsButtons">
    <table width="100%" border="0" cellspacing="0" cellpadding="10" class="uportal-background-light">
      <form name="workflow" method="post" action="{$baseActionURL}">
        <input type="hidden" name="uPCM_action" value="changeMe"/>
        <input type="hidden" name="uPCM_capture" value="selectGroups"/>
        <input type="hidden" name="uPCM_step" value="changeMe"/>

      <tr>
        <td>
          <input type="submit" name="uPCM_submit" value="&lt; Iepriekšējais" onclick="document.workflow.uPCM_action.value='selectCategories'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Nākamais &gt;" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Apskats" onclick="document.workflow.uPCM_action.value='reviewChannel'" class="uportal-button"/>
          <input type="submit" name="uPCM_submit" value="Atcelt" onclick="document.workflow.uPCM_action.value='cancel'" class="uportal-button"/>
        </td>
      </tr>

      </form>

    </table>
</xsl:template>

</xsl:stylesheet><!-- Stylesheet edited using Stylus Studio - (c)1998-2002 eXcelon Corp. -->