<?php
namespace calendar\page;

/*
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
 */


use calendar\data\event\date\CategoryEventDateList;

/**
 * Shows the list of past events.
 *
 * @author      jens1o
 * @copyright   Jens Hausdorf 2018
 * @license     GNU General Public License
 * @package     calendar
 * @subpackage  page
 */
class PastEventListPage extends UpcomingEventListPage
{
    /**
     * @inheritDoc
     */
    public $sortOrder = 'DESC';

    /**
     * @inheritDoc
     */
    protected function initObjectList()
    {
        // DO NOT set start time to 0, because then the filter won't be applied :z
        $this->objectList = new CategoryEventDateList(($this->categoryID ? [$this->categoryID] : []), 1, TIME_NOW, true);

        if ($this->user) {
            $this->objectList->getConditionBuilder()->add('event_date.eventID IN (SELECT eventID FROM calendar' . WCF_N . '_event WHERE userID = ?)', [$this->user->userID]);
        }
    }
}