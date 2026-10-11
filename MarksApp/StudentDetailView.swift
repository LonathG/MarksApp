import SwiftUI

struct StudentDetailView: View {
    let student: Student

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Profile Card
                VStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 76))
                        .foregroundStyle(.secondary)
                        .frame(width: 80, height: 80)

                    Text(student.name)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.primary)

                    // Grade Badge & Accessible Status Badge
                    HStack(spacing: 8) {
                        // Grade Badge
                        HStack(spacing: 4) {
                            Text("Grade")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(student.grade)
                                .font(.subheadline)
                                .bold()
                                .foregroundStyle(.primary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(uiColor: .tertiarySystemFill))
                        .clipShape(Capsule())

                        // Pass / Fail Status Badge (SF Symbol + Text + Color)
                        HStack(spacing: 6) {
                            Image(systemName: student.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.subheadline)
                            Text(student.passed ? "Passed Examination" : "Needs Improvement (Failed)")
                                .font(.subheadline)
                                .bold()
                        }
                        .foregroundStyle(student.passed ? .green : .red)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background((student.passed ? Color.green : Color.red).opacity(0.15))
                        .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)

                // Key Information Card
                VStack(spacing: 16) {
                    // Mark Row
                    HStack {
                        Label {
                            Text("Score / Mark")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "percent")
                                .foregroundStyle(.blue)
                                .frame(width: 24, height: 24)
                        }

                        Spacer()

                        Text("\(student.mark) / 100")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.primary)
                    }

                    Divider()

                    // Grade Row
                    HStack {
                        Label {
                            Text("Grade")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "rosette")
                                .foregroundStyle(.orange)
                                .frame(width: 24, height: 24)
                        }

                        Spacer()

                        Text(student.grade)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.primary)
                    }

                    Divider()

                    // Status Row (Symbols and text reinforce status without relying only on colour)
                    HStack {
                        Label {
                            Text("Academic Status")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "graduationcap")
                                .foregroundStyle(.indigo)
                                .frame(width: 24, height: 24)
                        }

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: student.passed ? "checkmark" : "xmark")
                                .font(.caption)
                                .bold()
                            Text(student.passed ? "Pass" : "Fail")
                                .font(.headline)
                                .bold()
                        }
                        .foregroundStyle(student.passed ? .green : .red)
                    }
                }
                .padding(20)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)

                // Grading Scheme Reference Card
                VStack(alignment: .leading, spacing: 10) {
                    Label("Grading Scheme", systemImage: "chart.bar.doc.horizontal")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.secondary)

                    VStack(spacing: 4) {
                        gradeScaleRow(range: "80 – 100", letter: "A", isCurrent: student.grade == "A")
                        gradeScaleRow(range: "75 – 79", letter: "A-", isCurrent: student.grade == "A-")
                        gradeScaleRow(range: "70 – 74", letter: "B+", isCurrent: student.grade == "B+")
                        gradeScaleRow(range: "65 – 69", letter: "B", isCurrent: student.grade == "B")
                        gradeScaleRow(range: "60 – 64", letter: "B-", isCurrent: student.grade == "B-")
                        gradeScaleRow(range: "55 – 59", letter: "C+", isCurrent: student.grade == "C+")
                        gradeScaleRow(range: "45 – 54", letter: "C", isCurrent: student.grade == "C")
                        gradeScaleRow(range: "40 – 44", letter: "C-", isCurrent: student.grade == "C-")
                        gradeScaleRow(range: "Below 40", letter: "F", isCurrent: student.grade == "F")
                    }
                }
                .padding(16)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)

                // Guidance & Remarks Card
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: student.passed ? "info.circle.fill" : "exclamationmark.triangle.fill")
                        .font(.title3)
                        .foregroundStyle(student.passed ? .blue : .orange)
                        .frame(width: 24, height: 24)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(student.passed ? "Passing Requirement Met" : "Remedial Support Recommended")
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.primary)

                        Text(student.passed
                             ? "The student has satisfied the passing benchmark (≥ 50 marks) for module SE4041 with grade \(student.grade)."
                             : "The student scored below the passing benchmark (50 marks). Additional guidance is recommended.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(16)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 8)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle(student.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func gradeScaleRow(range: String, letter: String, isCurrent: Bool) -> some View {
        HStack {
            Text(range)
                .font(.footnote)
                .foregroundStyle(isCurrent ? .primary : .secondary)

            Spacer()

            Text(letter)
                .font(.footnote)
                .bold()
                .foregroundStyle(isCurrent ? Color.accentColor : .secondary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(isCurrent ? Color.accentColor.opacity(0.12) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    NavigationStack {
        StudentDetailView(student: Student(name: "Amal", mark: 72))
    }
}
