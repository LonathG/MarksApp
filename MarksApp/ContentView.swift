import SwiftUI

struct Student: Identifiable {

    let id = UUID()

    var name: String
    var mark: Int

    var passed: Bool {
        mark >= 50
    }
}

struct ContentView: View {
    
    @State private var students = [
        Student(name: "Amal", mark: 72),
        Student(name: "Nimali", mark: 45),
        Student(name: "Ruwan", mark: 58)
    ]

    @State private var studentName = ""
    @State private var mark = ""

    private var isInputValid: Bool {
        let trimmedName = studentName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty, let markValue = Int(mark.trimmingCharacters(in: .whitespaces)) else {
            return false
        }
        return (0...100).contains(markValue)
    }

    private func addStudentRecord() {
        let trimmedName = studentName.trimmingCharacters(in: .whitespaces)
        guard let markValue = Int(mark.trimmingCharacters(in: .whitespaces)), !trimmedName.isEmpty else {
            return
        }

        let newStudent = Student(name: trimmedName, mark: markValue)
        students.append(newStudent)

        // Reset input fields
        studentName = ""
        mark = ""
    }

    var body: some View {
        NavigationStack {
            List {
                // Section 1: Input Form for Adding a Student
                Section {
                    VStack(alignment: .leading, spacing: 14) {
                        // Student Name Field
                        HStack(spacing: 12) {
                            Image(systemName: "person")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .frame(width: 24, height: 24)

                            TextField("Student Name", text: $studentName)
                                .font(.body)
                                .autocorrectionDisabled()
                        }
                        .padding(10)
                        .background(Color(uiColor: .tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        // Mark Field
                        HStack(spacing: 12) {
                            Image(systemName: "number")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .frame(width: 24, height: 24)

                            TextField("Mark (0 - 100)", text: $mark)
                                .font(.body)
                                .keyboardType(.numberPad)
                        }
                        .padding(10)
                        .background(Color(uiColor: .tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        // Live Result Feedback (Not relying only on colour)
                        if let markValue = Int(mark.trimmingCharacters(in: .whitespaces)) {
                            HStack(spacing: 6) {
                                Image(systemName: markValue >= 50 ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.caption)
                                Text(markValue >= 50 ? "Result Preview: Passed (≥ 50)" : "Result Preview: Failed (< 50)")
                                    .font(.caption)
                                    .bold()
                            }
                            .foregroundStyle(markValue >= 50 ? .green : .red)
                            .padding(.vertical, 2)
                        }

                        // Add Student Button with descriptive action label
                        Button(action: addStudentRecord) {
                            HStack(spacing: 8) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.headline)
                                Text("Add Student Record")
                                    .font(.headline)
                                    .bold()
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(isInputValid ? Color.blue : Color.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .disabled(!isInputValid)
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                } header: {
                    Label("Add Student Record", systemImage: "person.badge.plus")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.secondary)
                }

                // Section 2: Student Marks List
                Section {
                    ForEach(students) { student in
                        NavigationLink {
                            StudentDetailView(student: student)
                        } label: {
                            HStack(spacing: 12) {
                                // Student Avatar Icon
                                Image(systemName: "person.fill")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 34, height: 34)
                                    .background(Color(uiColor: .tertiarySystemFill))
                                    .clipShape(Circle())

                                // Student Name & Status Label
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(student.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)

                                    Text(student.passed ? "Passed" : "Failed")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                // Mark & Status Badge (Both SF Symbol and text used to ensure accessibility)
                                HStack(spacing: 8) {
                                    Text("\(student.mark)")
                                        .font(.headline)
                                        .bold()
                                        .foregroundStyle(.primary)

                                    HStack(spacing: 4) {
                                        Image(systemName: student.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .font(.caption)
                                        Text(student.passed ? "Pass" : "Fail")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundStyle(student.passed ? .green : .red)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background((student.passed ? Color.green : Color.red).opacity(0.15))
                                    .clipShape(Capsule())
                                }
                            }
                            .padding(.vertical, 3)
                        }
                    }
                    .onDelete { indexSet in
                        students.remove(atOffsets: indexSet)
                    }
                } header: {
                    Label("Student Results (\(students.count))", systemImage: "list.clipboard")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }
}

#Preview {
    ContentView()
}
