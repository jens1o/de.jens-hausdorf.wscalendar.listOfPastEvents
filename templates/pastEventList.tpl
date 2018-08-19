{*
    listOfPastEvents - Shows the list of events laying in the past. (WoltLab Suite Calendar Plugin)
    Copyright (C) 2018 Jens Hausdorf

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <https://www.gnu.org/licenses/>.
*}

{if $user}
	{capture assign='contentTitle'}{lang}calendar.event.userEvents{/lang}{/capture}
	{capture assign='pageTitle'}{lang}calendar.event.userEvents{/lang}{if $pageNo > 1} - {lang}wcf.page.pageNo{/lang}{/if}{/capture}
{/if}

{capture assign='sidebarRight'}
	{hascontent}
		{* The original box lacks this `data-static-box-identifier` information for specific css styling :| *}
		<section class="box" data-static-box-identifier="de.jens-hausdorf.wscalendar.pastEventListCategory">
			<h2 class="boxTitle">{lang}calendar.event.categories{/lang}</h2>

			<div class="boxContent">
				<ol class="boxMenu">
					{content}
						{foreach from=$categoryList item=categoryItem}
							<li{if $category && $category->categoryID == $categoryItem->categoryID} class="active"{/if} data-category-id="{@$categoryItem->categoryID}">
								<a href="{link application='calendar' controller='PastEventList' object=$categoryItem->getDecoratedObject()}{/link}" class="boxMenuLink">
									{if $categoryItem->eventColor}
										<span class="calendarCategoryEventColor" style="background-color: {$categoryItem->eventColor}"></span>
									{/if}
									<span class="boxMenuLinkTitle">{$categoryItem->getTitle()}</span>
								</a>
								{if $category && ($category->categoryID == $categoryItem->categoryID || $category->isParentCategory($categoryItem->getDecoratedObject())) && $categoryItem->hasChildren()}
									<ol class="boxMenuDepth1">
										{foreach from=$categoryItem item=subCategoryItem}
											<li{if $category && $category->categoryID == $subCategoryItem->categoryID} class="active"{/if} data-category-id="{@$subCategoryItem->categoryID}">
												<a href="{link application='calendar' controller='PastEventList' object=$subCategoryItem->getDecoratedObject()}{/link}" class="boxMenuLink">
													{if $subCategoryItem->eventColor}
														<span class="calendarCategoryEventColor" style="background-color: {$subCategoryItem->eventColor}"></span>
													{/if}
													<span class="boxMenuLinkTitle">{$subCategoryItem->getTitle()}</span>
												</a>

												{if $category && ($category->categoryID == $subCategoryItem->categoryID || $category->parentCategoryID == $subCategoryItem->categoryID) && $subCategoryItem->hasChildren()}
													<ol class="boxMenuDepth2">
														{foreach from=$subCategoryItem item=subSubCategoryItem}
															<li{if $category && $category->categoryID == $subSubCategoryItem->categoryID} class="active"{/if} data-category-id="{@$subSubCategoryItem->categoryID}">
																<a href="{link application='calendar' controller='PastEventList' object=$subSubCategoryItem->getDecoratedObject()}{/link}" class="boxMenuLink">
																	{if $subSubCategoryItem->eventColor}
																		<span class="calendarCategoryEventColor" style="background-color: {$subSubCategoryItem->eventColor}"></span>
																	{/if}
																	<span class="boxMenuLinkTitle">{$subSubCategoryItem->getTitle()}</span>
																</a>
															</li>
														{/foreach}
													</ol>
												{/if}
											</li>
										{/foreach}
									</ol>
								{/if}
							</li>
						{/foreach}
					{/content}
				</ol>
			</div>
		</section>
	{/hascontent}
{/capture}

{capture assign='headerNavigation'}
	{include file='headerNavigationIcons' application='calendar'}
{/capture}

{capture assign='contentHeaderNavigation'}
	{if $__wcf->user->userID && $__wcf->session->getPermission('user.calendar.canImportEvent')}<li><a href="{link application='calendar' controller='EventImport'}{/link}" class="button"><span class="icon icon16 fa-upload"></span> <span>{lang}calendar.event.import{/lang}</span></a></li>{/if}
	{if $__wcf->user->userID && $__wcf->session->getPermission('user.calendar.canCreateEvent')}<li><a href="{link application='calendar' controller='EventAdd'}{if $category}categoryID={@$category->categoryID}{/if}{/link}" class="button buttonPrimary"><span class="icon icon16 fa-plus"></span> <span>{lang}calendar.event.add{/lang}</span></a></li>{/if}
	<li><a href="{link application='calendar' controller='UpcomingEventList'}{if $category}categoryID={@$category->categoryID}{/if}{/link}" class="button"><span class="icon icon16 fa-clock-o"></span> <span>{lang}calendar.event.upcomingEvents{/lang}</span></a></li>
{/capture}

{include file='header'}

{hascontent}
	<div class="paginationTop">
		{content}
			{assign var='linkParameters' value=''}
			{if $user}{append var='linkParameters' value='&userID='|concat:$user->userID}{/if}
			{pages print=true assign=pagesLinks application='calendar' controller='PastEventList' object=$category link="pageNo=%d$linkParameters"}
		{/content}
	</div>
{/hascontent}

{if $items}
	{include file='groupedEventDateList' application='calendar'}
{else}
	<p class="info">{lang}wcf.global.noItems{/lang}</p>
{/if}

<footer class="contentFooter">
	{hascontent}
		<div class="paginationBottom">
			{content}{@$pagesLinks}{/content}
		</div>
	{/hascontent}

	{hascontent}
		<nav class="contentFooterNavigation">
			<ul>
				{content}
					{if $__wcf->user->userID && $__wcf->session->getPermission('user.calendar.canImportEvent')}<li><a href="{link application='calendar' controller='EventImport'}{/link}" class="button"><span class="icon icon16 fa-upload"></span> <span>{lang}calendar.event.import{/lang}</span></a></li>{/if}
					{if $__wcf->user->userID && $__wcf->session->getPermission('user.calendar.canCreateEvent')}<li><a href="{link application='calendar' controller='EventAdd'}{if $category}categoryID={@$category->categoryID}{/if}{/link}" class="button buttonPrimary"><span class="icon icon16 fa-plus"></span> <span>{lang}calendar.event.add{/lang}</span></a></li>{/if}
					{event name='contentFooterNavigation'}
				{/content}
			</ul>
		</nav>
	{/hascontent}
</footer>

{include file='footer'}
