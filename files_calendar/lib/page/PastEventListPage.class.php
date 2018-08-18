<?php
namespace calendar\page;

use calendar\data\event\date\CategoryEventDateList;

/**
 * Shows the list of past events.
 *
 * @author      jens1o
 * @copyright   Jens Hausdorf 2018
 * @license     GNU Lesser General Public License
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