//
// Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

// #internal

internal class ListNode<Element> : Printable {
	/**
		:name:	next
		:description:	Points to the successor element in the List.
		:returns:	ListNode<Element>?
	*/
	internal var next: ListNode<Element>?

	/**
		:name:	previous
		:description:	points to the predacessor element in the List.
		:returns:	ListNode<Element>?
	*/
	internal var previous: ListNode<Element>?

	/**
		:name:	data
		:description:	Satellite data.
		:returns:	Element?
	*/
	internal var element: Element?

	/**
		:name:	description
		:description:	Conforms to the Printable Protocol.
		:returns:	String
	*/
	internal var description: String {
		return "\(element)"
	}

	/**
		:name:	init
		:description:	Constructor.
	*/
	internal init(next: ListNode<Element>?, previous: ListNode<Element>?, element: Element?) {
		self.next = next
		self.previous = previous
		self.element = element
	}
}
