<%
        List<AverageResult> averages = (List<AverageResult>) request.getAttribute("averageResults");
        if (averages == null || averages.isEmpty()) {
    %>
        <div class="alert alert-info">No quiz results found for your quizzes.</div>
    <%
        } else {
    %>
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Quiz Title</th>
                    <th>Category</th>
                    <th>Level</th>
                    <th>Test No</th>
                    <th>Average Score (%)</th>
                    <th>Total Attempts</th>
                </tr>
            </thead>
            <tbody>
            <% for (AverageResult ar : averages) { %>
                <tr>
                    <td><%= ar.getQuizTitle() %></td>
                    <td><%= ar.getQuizCategory() %></td>
                    <td><%= ar.getQuizLevel() %></td>
                    <td><%= ar.getTestNum() %></td>
                    <td><%= String.format("%.2f", ar.getAvgScore()) %></td>
                    <td><%= ar.getTotalAttempts() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <%
        }
    %>
</div>