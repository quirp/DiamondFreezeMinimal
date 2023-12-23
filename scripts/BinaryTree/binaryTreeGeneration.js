function generateBinarySearchSolidityFunction(data, structType) {
  const solidityCode = `
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract BinarySearchContract {
        struct ${structType} {
            // Define your struct members here
            uint256 field1;
            string field2;
            // Add more fields as needed
        }

        // Function to perform binary search and return the corresponding struct
        function binarySearch(uint16 key) external pure returns (${structType} memory) {
            ${generateBinarySearch(data, structType)}
        }
    }
  `;

  return solidityCode;
}

function generateBinarySearch(data, structType) {
  const sortedData = data.sort((a, b) => a[0] - b[0]); // Ensure the data is sorted

  function generateSearchSection(start, end) {
    if (start > end) {
      return ''; // Return nothing if key is not found
    }

    const mid = Math.floor((start + end) / 2);
    const [midKey, midValues] = sortedData[mid];
    const structInstantiation = `${structType}(${midValues.join(', ')})`;

    if (start === end) {
      // Only generate a final if statement if there's only one element left
      return `
            if (key == ${midKey}) {
                return ${structInstantiation};
            }`;
    } else {
      // Generate regular if statements without empty else or else if blocks
      return `
            if (key == ${midKey}) {
                return ${structInstantiation};
            } else {
                if (key < ${midKey}) {
                    ${generateSearchSection(start, mid)}
                } else {
                    ${generateSearchSection(mid + 1, end)}
                }
            }`;
    }
  }

  return generateSearchSection(0, sortedData.length - 1);
}

// Example data: Tuple list of uint16 values and their corresponding struct values
const data = [
  [50, [111, "Value1"]],
  [100, [123, "Value2"]],
  [150, [234, "Value3"]],
  [200, [456, "Value4"]],
  [250, [789, "Value5"]],
  [300, [567, "Value6"]],
  [350, [890, "Value7"]],
  [400, [123, "Value8"]],
  [450, [567, "Value9"]],
  [500, [890, "Value10"]],
  // Add more data entries as needed
];

const structType = 'MyStruct'; // Replace with the actual struct type

// Generate Solidity code
const solidityCode = generateBinarySearchSolidityFunction(data, structType);

console.log(solidityCode);
