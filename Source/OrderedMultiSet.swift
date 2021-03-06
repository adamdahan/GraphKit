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

public class OrderedMultiSet<Element : Comparable> : Probability<Element>, CollectionType, Comparable, Equatable, Printable {
	public typealias Generator = GeneratorOf<Element>
	public typealias OrderedIndex = RedBlackTree<Element, Int>
	
	/**
		:name:	tree
		:description:	Internal storage of elements.
		:returns:	RedBlackTree<Element, Element>
	*/
	internal var tree: RedBlackTree<Element, Element>

	/**
		:name:	description
		:description:	Conforms to the Printable Protocol. Outputs the
		data in the OrderedMultiSet in a readable format.
		:returns:	String
	*/
	public var description: String {
		var output: String = "["
		for var i: Int = 0, l = count - 1; i <= l; ++i {
			output += "\(self[i])"
			if i != l {
				output += ", "
			}
		}
		return output + "]"
	}

	/**
		:name:	first
		:description:	Get the first node value in the tree, this is
		the first node based on the order of keys where
		k1 <= k2 <= K3 ... <= Kn
		:returns:	Element?
	*/
	public var first: Element? {
		return tree.first?.value
	}

	/**
		:name:	last
		:description:	Get the last node value in the tree, this is
		the last node based on the order of keys where
		k1 <= k2 <= K3 ... <= Kn
		:returns:	Element?
	*/
	public var last: Element? {
		return tree.last?.value
	}

	/**
		:name:	isEmpty
		:description:	A boolean of whether the RedBlackTree is empty.
		:returns:	Bool
	*/
	public var isEmpty: Bool {
		return 0 == count
	}

	/**
		:name:	startIndex
		:description:	Conforms to the CollectionType Protocol.
		:returns:	Int
	*/
	public var startIndex: Int {
		return 0
	}

	/**
		:name:	endIndex
		:description:	Conforms to the CollectionType Protocol.
		:returns:	Int
	*/
	public var endIndex: Int {
		return count
	}

	/**
		:name:	init
		:description:	Constructor
	*/
	public override init() {
		tree = RedBlackTree<Element, Element>(uniqueKeys: false)
	}

	/**
		:name:	init
		:description:	Constructor
	*/
	public convenience init(elements: Element...) {
		self.init(elements: elements)
	}

	/**
		:name:	init
		:description:	Constructor
	*/
	public convenience init(elements: Array<Element>) {
		self.init()
		insert(elements)
	}

	//
	//	:name:	generate
	//	:description:	Conforms to the SequenceType Protocol. Returns
	//	the next value in the sequence of nodes using
	//	index values [0...n-1].
	//	:returns:	OrderedMultiSet.Generator
	//	
	public func generate() -> OrderedMultiSet.Generator {
		var index = startIndex
		return GeneratorOf {
			if index < self.endIndex {
				return self[index++]
			}
			return nil
		}
	}

	/**
		:name:	operator [0...count - 1]
		:description:	Allows array like access of the index.
		Items are kept in order, so when iterating
		through the items, they are returned in their
		ordered form.
		:returns:	Element
	*/
	public subscript(index: Int) -> Element {
		return tree[index].key
	}

	/**
		:name:	indexOf
		:description:	Returns the Index of a given member, or nil if the member is not present in the set.
		:returns:	OrderedMultiSet.OrderedIndex
	*/
	public func indexOf(elements: Element...) -> OrderedMultiSet.OrderedIndex {
		return indexOf(elements)
	}
	
	/**
		:name:	indexOf
		:description:	Returns the Index of a given member, or nil if the member is not present in the set.
		:returns:	OrderedMultiSet.OrderedIndex
	*/
	public func indexOf(elements: Array<Element>) -> OrderedMultiSet.OrderedIndex {
		return tree.indexOf(elements)
	}
	
	/**
		:name:	contains
		:description:	A boolean check if values exists
		in the set.
		:returns:	Bool
	*/
	public func contains(elements: Element...) -> Bool {
		return contains(elements)
	}
	
	/**
		:name:	contains
		:description:	A boolean check if an array of values exist
		in the set.
		:returns:	Bool
	*/
	public func contains(elements: Array<Element>) -> Bool {
		if 0 == elements.count {
			return false
		}
		for x in elements {
			if nil == tree.findValueForKey(x) {
				return false
			}
		}
		return true
	}
	
	/**
		:name:	countOf
		:description:	Conforms to ProbabilityType protocol.
		:returns:	Int
	*/
	public override func countOf(elements: Element...) -> Int {
		return tree.countOf(elements)
	}

	/**
		:name:	countOf
		:description:	Conforms to ProbabilityType protocol.
		:returns:	Int
	*/
	public override func countOf(elements: Array<Element>) -> Int {
		return tree.countOf(elements)
	}

	/**
		:name:	insert
		:description:	Inserts new elements into the OrderedMultiSet.
	*/
	public func insert(elements: Element...) {
		insert(elements)
	}

	/**
		:name:	insert
		:description:	Inserts new elements into the OrderedMultiSet.
	*/
	public func insert(elements: Array<Element>) {
		for x in elements {
			tree.insert(x, value: x)
		}
		count = tree.count
	}

	/**
		:name:	remove
		:description:	Removes elements from the OrderedMultiSet.
		:returns:	OrderedMultiSet<Element>?
	*/
	public func remove(elements: Element...) -> OrderedMultiSet<Element>? {
		return remove(elements)
	}

	/**
		:name:	remove
		:description:	Removes elements from the OrderedMultiSet.
		:returns:	OrderedMultiSet<Element>?
	*/
	public func remove(elements: Array<Element>) -> OrderedMultiSet<Element>? {
		if let r: RedBlackTree<Element, Element> = tree.removeValueForKeys(elements) {
			let s: OrderedMultiSet<Element> = OrderedMultiSet<Element>()
			for (k, v) in r {
				s.insert(k)
			}
			count = tree.count
			return s
		}
		return nil
	}

	/**
		:name:	removeAll
		:description:	Remove all nodes from the tree.
	*/
	public func removeAll() {
		tree.removeAll()
		count = tree.count
	}

	/**
		:name:	intersect
		:description:	Return a new set with elements common to this set and a finite sequence of Sets.
		:returns:	OrderedMultiSet<Element>
	*/
	public func intersect(set: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
		let s: OrderedMultiSet<Element> = OrderedMultiSet<Element>()
		var i: Int = 0
		var j: Int = 0
		let k: Int = count
		let l: Int = set.count
		while k > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				++i
			} else if y < x {
				++j
			} else {
				s.insert(x)
				++i
				++j
			}
		}
		return s
	}
	
	/**
		:name:	intersectInPlace
		:description:	Insert elements of a finite sequence of Sets.
	*/
	public func intersectInPlace(set: OrderedMultiSet<Element>) {
		var i: Int = 0
		var j: Int = 0
		let l: Int = set.count
		while count > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				tree.removeInstanceOfValueForKey(x)
				count = tree.count
			} else if y < x {
				++j
			} else {
				++i
				++j
			}
		}
	}
	
	/**
		:name:	union
		:description:	Return a new Set with items in both this set and a finite sequence of Sets.
		:returns:	OrderedMultiSet<Element>
	*/
	public func union(set: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
		let s: OrderedMultiSet<Element> = OrderedMultiSet<Element>()
		var i: Int = 0
		var j: Int = 0
		let k: Int = count
		let l: Int = set.count
		while k > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				s.insert(x)
				++i
			} else if y < x {
				s.insert(y)
				++j
			} else {
				s.insert(x)
				++i
				++j
			}
		}
		while k > i {
			s.insert(self[i++])
		}
		while l > j {
			s.insert(set[j++])
		}
		return s
	}
	
	/**
		:name:	unionInPlace
		:description:	Return a new Set with items in both this set and a finite sequence of Sets.
	*/
	public func unionInPlace(set: OrderedMultiSet<Element>) {
		var i: Int = 0
		var j: Int = 0
		let l: Int = set.count
		while count > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				++i
			} else if y < x {
				insert(y)
				++j
			} else {
				++i
				++j
			}
		}
		while l > j {
			insert(set[j++])
		}
	}
	
	/**
		:name:	subtract
		:description:	Return a new set with elements in this set that do not occur in a finite sequence of Sets.
		:returns:	OrderedMultiSet<Element>
	*/
	public func subtract(set: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
		let s: OrderedMultiSet<Element> = OrderedMultiSet<Element>()
		var i: Int = 0
		var j: Int = 0
		let k: Int = count
		let l: Int = set.count
		while k > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				s.insert(x)
				++i
			} else if y < x {
				++j
			} else {
				++i
				++j
			}
		}
		while k > i {
			s.insert(self[i++])
		}
		return s
	}
	
	/**
		:name:	subtractInPlace
		:description:	Remove all elements in the set that occur in a finite sequence of Sets.
	*/
	public func subtractInPlace(set: OrderedMultiSet<Element>) {
		var i: Int = 0
		var j: Int = 0
		let l: Int = set.count
		while count > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				++i
			} else if y < x {
				++j
			} else {
				tree.removeInstanceOfValueForKey(x)
				count = tree.count
				++j
			}
		}
	}
	
	/**
		:name:	exclusiveOr
		:description:	Return a new set with elements that are either in the set or a finite sequence but do not occur in both.
		:returns:	OrderedMultiSet<Element>
	*/
	public func exclusiveOr(set: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
		let s: OrderedMultiSet<Element> = OrderedMultiSet<Element>()
		var i: Int = 0
		var j: Int = 0
		let k: Int = count
		let l: Int = set.count
		while k > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				s.insert(x)
				++i;
			} else if y < x {
				s.insert(y)
				++j
			} else {
				i += countOf(x)
				j += set.countOf(y)
			}
		}
		while k > i {
			s.insert(self[i++])
		}
		while l > j {
			s.insert(set[j++])
		}
		return s
	}
	
	/**
		:name:	exclusiveOrInPlace
		:description:	For each element of a finite sequence, remove it from the set if it is a
		common element, otherwise add it to the set. Repeated elements of the sequence will be
		ignored.
	*/
	public func exclusiveOrInPlace(set: OrderedMultiSet<Element>) {
		var i: Int = 0
		var j: Int = 0
		let l: Int = set.count
		while count > i && l > j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				++i
			} else if y < x {
				insert(y)
				++j
			} else {
				remove(x)
				++j
			}
		}
		while l > j {
			insert(set[j++])
		}
	}
	
	/**
		:name:	isDisjointWith
		:description:	Returns true if no elements in the set are in a finite sequence of Sets.
		:returns:	Bool
	*/
	public func isDisjointWith(set: OrderedMultiSet<Element>) -> Bool {
		var i: Int = count - 1
		var j: Int = set.count - 1
		while 0 <= i && 0 <= j {
			let x: Element = self[i]
			let y: Element = set[j]
			if x < y {
				--j
			} else if y < x {
				--i
			} else {
				return false
			}
		}
		return true
	}
	
	/**
		:name:	isSubsetOf
		:description:	Returns true if the set is a subset of a finite sequence as a Set.
		:returns:	Bool
	*/
	public func isSubsetOf(set: OrderedMultiSet<Element>) -> Bool {
		if count > set.count {
			return false
		}
		for x in self {
			if !set.contains(x) {
				return false
			}
		}
		return true
	}
	
	/**
		:name:	isStrictSubsetOf
		:description:	Returns true if the set is a subset of a finite sequence as a Set but not equal.
		:returns:	Bool
	*/
	public func isStrictSubsetOf(set: OrderedMultiSet<Element>) -> Bool {
		return count < set.count && isSubsetOf(set)
	}
	
	/**
		:name:	isSupersetOf
		:description:	Returns true if the set is a superset of a finite sequence as a Set.
		:returns:	Bool
	*/
	public func isSupersetOf(set: OrderedMultiSet<Element>) -> Bool {
		if count < set.count {
			return false
		}
		for x in set {
			if !contains(x) {
				return false
			}
		}
		return true
	}
	
	/**
		:name:	isStrictSupersetOf
		:description:	Returns true if the set is a superset of a finite sequence as a Set but not equal.
		:returns:	Bool
	*/
	public func isStrictSupersetOf(set: OrderedMultiSet<Element>) -> Bool {
		return count > set.count && isSupersetOf(set)
	}
}

public func ==<Element: Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> Bool {
	if lhs.count != rhs.count {
		return false
	}
	for var i: Int = lhs.count - 1; 0 <= i; --i {
		if lhs[i] != rhs[i] {
			return false
		}
	}
	return true
}

public func +<Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
	return lhs.union(rhs)
}

public func -<Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> OrderedMultiSet<Element> {
	return lhs.subtract(rhs)
}

public func <=<Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> Bool {
	return lhs.isSubsetOf(rhs)
}

public func >=<Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> Bool {
	return lhs.isSupersetOf(rhs)
}

public func ><Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> Bool {
	return lhs.isStrictSupersetOf(rhs)
}

public func <<Element : Comparable>(lhs: OrderedMultiSet<Element>, rhs: OrderedMultiSet<Element>) -> Bool {
	return lhs.isStrictSubsetOf(rhs)
}
