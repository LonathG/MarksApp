import SwiftUI

struct StudentDetailView: View {
    let student: Student

    // Academic grade based on standard benchmarks
    private var grade: String {
        switch student.mark {
        case 75...100: return "A (Distinction)"
        case 65..<75:  return "B (Credit)"
        case 50..<65:  return "C (Pass)"
        default:       return "F (Fail)"
        }
    }

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

                    // Accessible Status Badge (SF Symbol + Text + Color)
                    HStack(spacing: 6) {
                        Image(systemName: student.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.subheadline)
                        Text(student.passed ? "Passed Examination" : "Needs Improvement (Failed)")
                            .font(.subheadline)
                            .bold()
                    }
                    .foregroundStyle(student.passed ? .green : .red)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background((student.passed ? Color.green : Color.red).opacity(0.15))
                    .clipShape(Capsule())
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

                        Text(grade)
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
                             ? "The student has satisfied the passing benchmark (≥ 50 marks) for module SE4041."
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
}

#Preview {
    NavigationStack {
        StudentDetailView(student: Student(name: "Amal", mark: 72))
    }
}
