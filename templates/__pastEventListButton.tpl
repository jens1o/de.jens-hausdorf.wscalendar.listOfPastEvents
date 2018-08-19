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
<li><a href="{link application='calendar' controller='PastEventList'}{if $categoryID}categoryID={$categoryID}{/if}{/link}" class="button"><span class="icon icon16 fa-clock-o"></span> <span>{lang}calendar.event.pastEvents{/lang}</span></a></li>